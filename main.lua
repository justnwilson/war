-- so space can only be pressed one at a time
local spacePressed = false

local gameState = {
    player_hand = {},
    npc_hand = {},
    player_card = {},
    shuffled = {},
    player_plays = {},
    npc_plays = {},
    war_cards = {}, --face-down cards during war
    war_face = {}, --face-up cars during war
    deck = {
        {value = "14", suit = "Spades", spriteIndex = 39},  -- Ace of Spades
        {value = "14", suit = "Hearts", spriteIndex = 1},  -- Ace of Hearts
        {value = "14", suit = "Diamonds", spriteIndex = 20}, -- Ace of Diamonds
        {value = "14", suit = "Clubs", spriteIndex = 58},   -- Ace of Clubs
        {value = "13", suit = "Spades", spriteIndex = 5},   -- King of Spades
        {value = "13", suit = "Hearts", spriteIndex = 6},   -- King of Hearts
        {value = "13", suit = "Diamonds", spriteIndex = 7}, -- King of Diamonds
        {value = "13", suit = "Clubs", spriteIndex = 8},   -- King of Clubs
        {value = "12", suit = "Spades", spriteIndex = 9},   -- Queen of Spades
        {value = "12", suit = "Hearts", spriteIndex = 10},  -- Queen of Hearts
        {value = "12", suit = "Diamonds", spriteIndex = 11}, -- Queen of Diamonds
        {value = "12", suit = "Clubs", spriteIndex = 12},  -- Queen of Clubs
        {value = "11", suit = "Spades", spriteIndex = 13},  -- Jack of Spades
        {value = "11", suit = "Hearts", spriteIndex = 14},  -- Jack of Hearts
        {value = "11", suit = "Diamonds", spriteIndex = 15}, -- Jack of Diamonds
        {value = "11", suit = "Clubs", spriteIndex = 16},  -- Jack of Clubs
        {value = "10", suit = "Spades", spriteIndex = 17}, -- 10 of Spades
        {value = "10", suit = "Hearts", spriteIndex = 18}, -- 10 of Hearts
        {value = "10", suit = "Diamonds", spriteIndex = 19}, -- 10 of Diamonds
        {value = "10", suit = "Clubs", spriteIndex = 20},  -- 10 of Clubs
        {value = "9", suit = "Spades", spriteIndex = 21},  -- 9 of Spades
        {value = "9", suit = "Hearts", spriteIndex = 22},  -- 9 of Hearts
        {value = "9", suit = "Diamonds", spriteIndex = 23}, -- 9 of Diamonds
        {value = "9", suit = "Clubs", spriteIndex = 24},  -- 9 of Clubs
        {value = "8", suit = "Spades", spriteIndex = 25},  -- 8 of Spades
        {value = "8", suit = "Hearts", spriteIndex = 26},  -- 8 of Hearts
        {value = "8", suit = "Diamonds", spriteIndex = 27}, -- 8 of Diamonds
        {value = "8", suit = "Clubs", spriteIndex = 28},  -- 8 of Clubs
        {value = "7", suit = "Spades", spriteIndex = 29},  -- 7 of Spades
        {value = "7", suit = "Hearts", spriteIndex = 30},  -- 7 of Hearts
        {value = "7", suit = "Diamonds", spriteIndex = 31}, -- 7 of Diamonds
        {value = "7", suit = "Clubs", spriteIndex = 32},  -- 7 of Clubs
        {value = "6", suit = "Spades", spriteIndex = 33},  -- 6 of Spades
        {value = "6", suit = "Hearts", spriteIndex = 34},  -- 6 of Hearts
        {value = "6", suit = "Diamonds", spriteIndex = 35}, -- 6 of Diamonds
        {value = "6", suit = "Clubs", spriteIndex = 36},  -- 6 of Clubs
        {value = "5", suit = "Spades", spriteIndex = 37},  -- 5 of Spades
        {value = "5", suit = "Hearts", spriteIndex = 38},  -- 5 of Hearts
        {value = "5", suit = "Diamonds", spriteIndex = 39}, -- 5 of Diamonds
        {value = "5", suit = "Clubs", spriteIndex = 40},  -- 5 of Clubs
        {value = "4", suit = "Spades", spriteIndex = 41},  -- 4 of Spades
        {value = "4", suit = "Hearts", spriteIndex = 42},  -- 4 of Hearts
        {value = "4", suit = "Diamonds", spriteIndex = 43}, -- 4 of Diamonds
        {value = "4", suit = "Clubs", spriteIndex = 44},  -- 4 of Clubs
        {value = "3", suit = "Spades", spriteIndex = 45},  -- 3 of Spades
        {value = "3", suit = "Hearts", spriteIndex = 46},  -- 3 of Hearts
        {value = "3", suit = "Diamonds", spriteIndex = 47}, -- 3 of Diamonds
        {value = "3", suit = "Clubs", spriteIndex = 48},  -- 3 of Clubs
        {value = "2", suit = "Spades", spriteIndex = 49},  -- 2 of Spades
        {value = "2", suit = "Hearts", spriteIndex = 50},  -- 2 of Hearts
        {value = "2", suit = "Diamonds", spriteIndex = 51}, -- 2 of Diamonds
        {value = "2", suit = "Clubs", spriteIndex = 52}   -- 2 of Clubs
    }
}

--is space key down?
function love.keypressed(key)
    if key == "space" then
        spacePressed = true
    end
end
--is space key up?
function love.keyreleased(key)
    if key == "space" then
        spacePressed = false
    end
end

function love.load()
    --seed the randomizer (ie. shuffledeck())
    math.randomseed(os.time())

    --TODO: move this out of love.load so that it can run more than once per app launch
    shuffleDeck()
    deal()

    --loads the file (i.e. image)
    deckfile = love.graphics.newImage("art/cards.png")

    SPRITE_WIDTH, SPRITE_HEIGHT = 944, 385
    QUAD_WIDTH, QUAD_HEIGHT = 48, 64
    quads = {} -- table for storing sprites

    --number of cards in a row
    --math.floor is used to return an integer
    cards_in_row = math.floor(SPRITE_WIDTH / QUAD_WIDTH)

    --loop to define quads
    for i = 1, 114 do --there's 114 quads in the image

        --horizontal position of a sprite
        local x = ((i - 1) % cards_in_row) * QUAD_WIDTH
        --now we derive the vertical position of a sprite
        --((i - 1) / cards_in_row) calculates how many rows have passed, returns integer
        local y = math.floor((i - 1) / cards_in_row) * QUAD_HEIGHT
        --the graphic of a particular card[i] is calculated using the x and y variables
        quads[i] = love.graphics.newQuad(x, y, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)
    end
end

--shuffle the deck
function shuffleDeck()
    for i, card in ipairs(gameState.deck) do
        --this creates a random position between 1 and the shuffled table max
        local pos = math.random(1, #gameState.shuffled +1) -- +1 is needed for the first iteration so that the second position is >= the first position
        --add the cards to the `shuffled` table at position `pos`
        table.insert(gameState.shuffled, pos, card)
    end
end


--deal out the cards
function deal()        
    for i, card in ipairs(gameState.shuffled) do
        if i % 2 == 0 then
            table.insert(gameState.player_hand, card)
        else
            table.insert(gameState.npc_hand, card)
        end
    end
end


function enoughCardsForWar()
    --ensure each player has enough cards for a war match
    if #gameState.player_hand < 4 then
        print("You don't have enough cards! You have lost.")
        return false
    elseif #gameState.npc_hand < 4 then
        print("The enemy is out of cards! You win!")
        return false
    end
    return true
end


function war()
    --each player needs at least 4 cards, or they lose
    if not enoughCardsForWar(gameState.player_hand, gameState.npc_hand) then
        return
    end

    inWar = true
    --take three cards from each player and place them in the war_cards table
    for i = 1, 3 do
        table.insert(gameState.war_cards, table.remove(gameState.player_hand, 1))
        table.insert(gameState.war_cards, table.remove(gameState.npc_hand, 1))
    end

    --compare the fourth card
    local player_card = table.remove(gameState.player_hand, 1)
    local npc_card = table.remove(gameState.npc_hand, 1)
    table.insert(gameState.war_cards, player_card)
    table.insert(gameState.war_cards, npc_card)

    if player_card.value > npc_card.value then
        print("You win the war!")
        --puts down-facing cards (war_cards) in players_hand
        for _, card in ipairs(gameState.war_cards) do
            table.insert(gameState.player_hand, card)
        end
            --puts up-facing cards in the player_hand
        for _, card in ipairs(gameState.war_face) do
            table.insert(gameState.player_hand, card)
        end
    
    elseif npc_card.value > player_card.value then
        print("You have lost the war!")
        for _, card in ipairs(gameState.war_cards) do
            table.insert(gameState.npc_hand, card)
        end
        for _, card in ipairs(gameState.war_face) do
            table.insert(gameState.npc_hand, card)
        end
    
    else
        print("It's a tie. Time for war!!!")
        war(gameState.player_hand, gameState.npc_hand)
    end

    --clear war tables
    gameState.war_cards = {}
    gameState.war_face = {}
end


function love.update(dt)
    if spacePressed then
        spacePressed = false
        --pull top card from each player to compare
        gameState.player_plays = table.remove(gameState.player_hand, 1)
        gameState.npc_plays = table.remove(gameState.npc_hand, 1)

        --check if the players have enough cards
        if not gameState.player_plays then
            print("You are out of cards, you lose.")
            return
        end

        if not gameState.npc_plays then
            print("The enemy is out of cards, you win!")
            return
        end

        --print some info of the cards being played
        for key, value in pairs(gameState.player_plays) do
            print(key, value)
        end
        for key, value in pairs(gameState.npc_plays) do
            print(key, value)
        end 

        --player wins
        if gameState.player_plays.value > gameState.npc_plays.value then
            table.insert(gameState.player_hand, gameState.player_plays)
            table.insert(gameState.player_hand, gameState.npc_plays)

        --npc wins
        elseif gameState.npc_plays.value > gameState.player_plays.value then
            table.insert(gameState.npc_hand, gameState.npc_plays)
            table.insert(gameState.npc_hand, gameState.player_plays)

        else --trigger the war function
            war(gameState.player_hand, gameState.npc_hand)
        end
    end
    inWar = false
end


function love.draw()
    --cards in players hands
    love.graphics.print("Player's Hand: " .. #gameState.player_hand .. " cards", 50, 450)
    love.graphics.print("NPC's Hand: " .. #gameState.npc_hand .. " cards", 50, 100)


    --draw the players face-up card
    if gameState.player_plays then
        --BREAKS: when using the desired player_plays
        --Errors here when player runs out of cards
        love.graphics.draw(deckfile, quads[gameState.player_hand[1].spriteIndex], 300, 400)
    end

    --draw the npc's face-up card
    if gameState.npc_plays then
        --BREAKS: when using the desired npc_plays
        --ERRORS here when npc runs out of cards
        love.graphics.draw(deckfile, quads[gameState.npc_hand[1].spriteIndex], 300, 50)
    end

    --draw the war_cards (face-down cards)
    --draw the war_face (face-up cards)
    if #gameState.war_face > 0 then
        for i, card in ipairs(gameState.war_cards) do
            love.graphics.draw(deckfile, quads[card[1].spriteIndex], 200, 250 + i * 20)
        end
    end
end



--[[
Tim's Notes: 
1. write down the rules of war as concrete items -- e.g. "a high card beats a lower card | Aces are the highest card (not lowest) | if two cards are the same face value, Spades beats Hearts beats clubs beats diamonds | players have a hand of 12 | loser gets the other person's card" etc

that helps you understand the exact logic you are shooting for, kind of like user stories in web

good to do this first so you are thinking architecturally from jump

2. figure out the minimum you need to display this on screen -- imo, be able to render two specific cards, and some text. this is the first code you will write, and you shoot for something concrete, like literally be able to just display two cards and "hello, world!" on the screen

3. figure out your "loop." this is core to game programming more than any other kind of programming. game programming is a constant loop of user input, then effect. in this case the one user action is basically "draw". so you would have some input e.g. spacebar trigger the draw event, then:

4. do your setup: draw two "hands" from a single "deck" (this will involve one "deck" array you set up manually, and two "hand" arrays for each player, a RNG, and a loop or two)

5. by doing so define your "game state" (in Lua, will be a "global" table that you declare at the top and set up in the .load method)

6. implement your player action "draw" where a card is drawn from the top (front or back aka) of each hand array, displayed, and compared

7. show the result (text or whatever, "you won" or "you lost" in terms of info)

8. mutate state (add both cards to "bottom" of loser's deck or however you want your rule to work)

9. close the loop, aka go to #6

10. finally handle endgame; display a message when someone wins, and optionally give the player an option to restart the game

i personally find it is cleanest and easiest to fully complete each step sequentially, with a minimum of UI. then when you are happy with the feel of the loop itself you can go in and polish everything, add animation or whatever you want.

    my one additional hint to you is regarding your card loader -- you are on the right track. however this might be a good place to a) measure the actual size of each card on the PNG, and b) think about using a loop

 ]]