--making a change


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
        {value = "13", suit = "Spades", spriteIndex = 51},   -- King of Spades
        {value = "13", suit = "Hearts", spriteIndex = 13},   -- King of Hearts
        {value = "13", suit = "Diamonds", spriteIndex = 32}, -- King of Diamonds
        {value = "13", suit = "Clubs", spriteIndex = 70},   -- King of Clubs
        {value = "12", suit = "Spades", spriteIndex = 50},   -- Queen of Spades
        {value = "12", suit = "Hearts", spriteIndex = 12},  -- Queen of Hearts
        {value = "12", suit = "Diamonds", spriteIndex = 31}, -- Queen of Diamonds
        {value = "12", suit = "Clubs", spriteIndex = 69},  -- Queen of Clubs
        {value = "11", suit = "Spades", spriteIndex = 49},  -- Jack of Spades
        {value = "11", suit = "Hearts", spriteIndex = 11},  -- Jack of Hearts
        {value = "11", suit = "Diamonds", spriteIndex = 30}, -- Jack of Diamonds
        {value = "11", suit = "Clubs", spriteIndex = 68},  -- Jack of Clubs
        {value = "10", suit = "Spades", spriteIndex = 48}, -- 10 of Spades
        {value = "10", suit = "Hearts", spriteIndex = 10}, -- 10 of Hearts
        {value = "10", suit = "Diamonds", spriteIndex = 29}, -- 10 of Diamonds
        {value = "10", suit = "Clubs", spriteIndex = 67},  -- 10 of Clubs
        {value = "9", suit = "Spades", spriteIndex = 47},  -- 9 of Spades
        {value = "9", suit = "Hearts", spriteIndex = 9},  -- 9 of Hearts
        {value = "9", suit = "Diamonds", spriteIndex = 28}, -- 9 of Diamonds
        {value = "9", suit = "Clubs", spriteIndex = 66},  -- 9 of Clubs
        {value = "8", suit = "Spades", spriteIndex = 46},  -- 8 of Spades
        {value = "8", suit = "Hearts", spriteIndex = 8},  -- 8 of Hearts
        {value = "8", suit = "Diamonds", spriteIndex = 27}, -- 8 of Diamonds
        {value = "8", suit = "Clubs", spriteIndex = 65},  -- 8 of Clubs
        {value = "7", suit = "Spades", spriteIndex = 45},  -- 7 of Spades
        {value = "7", suit = "Hearts", spriteIndex = 7},  -- 7 of Hearts
        {value = "7", suit = "Diamonds", spriteIndex = 26}, -- 7 of Diamonds
        {value = "7", suit = "Clubs", spriteIndex = 64},  -- 7 of Clubs
        {value = "6", suit = "Spades", spriteIndex = 44},  -- 6 of Spades
        {value = "6", suit = "Hearts", spriteIndex = 6},  -- 6 of Hearts
        {value = "6", suit = "Diamonds", spriteIndex = 25}, -- 6 of Diamonds
        {value = "6", suit = "Clubs", spriteIndex = 63},  -- 6 of Clubs
        {value = "5", suit = "Spades", spriteIndex = 43},  -- 5 of Spades
        {value = "5", suit = "Hearts", spriteIndex = 5},  -- 5 of Hearts
        {value = "5", suit = "Diamonds", spriteIndex = 24}, -- 5 of Diamonds
        {value = "5", suit = "Clubs", spriteIndex = 62},  -- 5 of Clubs
        {value = "4", suit = "Spades", spriteIndex = 42},  -- 4 of Spades
        {value = "4", suit = "Hearts", spriteIndex = 4},  -- 4 of Hearts
        {value = "4", suit = "Diamonds", spriteIndex = 23}, -- 4 of Diamonds
        {value = "4", suit = "Clubs", spriteIndex = 61},  -- 4 of Clubs
        {value = "3", suit = "Spades", spriteIndex = 41},  -- 3 of Spades
        {value = "3", suit = "Hearts", spriteIndex = 3},  -- 3 of Hearts
        {value = "3", suit = "Diamonds", spriteIndex = 22}, -- 3 of Diamonds
        {value = "3", suit = "Clubs", spriteIndex = 60},  -- 3 of Clubs
        {value = "2", suit = "Spades", spriteIndex = 40},  -- 2 of Spades
        {value = "2", suit = "Hearts", spriteIndex = 2},  -- 2 of Hearts
        {value = "2", suit = "Diamonds", spriteIndex = 21}, -- 2 of Diamonds
        {value = "2", suit = "Clubs", spriteIndex = 59}   -- 2 of Clubs
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
        gameState.player_plays = { table.remove(gameState.player_hand, 1) }
        gameState.npc_plays = { table.remove(gameState.npc_hand, 1) }

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
        for key, value in pairs(gameState.player_plays[1]) do
            print(key, value)
        end
        for key, value in pairs(gameState.npc_plays[1]) do
            print(key, value)
        end 

        --player wins
        if gameState.player_plays[1].value > gameState.npc_plays[1].value then
            table.insert(gameState.player_hand, gameState.player_plays)
            table.insert(gameState.player_hand, gameState.npc_plays)

        --npc wins
        elseif gameState.npc_plays[1].value > gameState.player_plays[1].value then
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
    if gameState.player_plays[1] then
        love.graphics.draw(deckfile, quads[gameState.player_plays[1].spriteIndex], 300, 400)
        love.graphics.print("Player plays: " .. gameState.player_plays[1].value .. " " .. gameState.player_plays[1].suit, 50, 470)

    else
        --not working yet
        love.graphics.draw(deckfile, quads[77], 300, 400)
    end

    --draw the npcs face-up card
    if gameState.npc_plays[1] then
        love.graphics.draw(deckfile, quads[gameState.npc_plays[1].spriteIndex], 300, 50)
        love.graphics.print("NPC plays: " .. gameState.npc_plays[1].value .. " " .. gameState.npc_plays[1].suit, 50, 120)


    else
        --not working yet
        love.graphics.draw(deckfile, quads[77], 300, 50)
    end
end