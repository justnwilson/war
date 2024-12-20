-- The best game of War you'll ever experience

local currentQuadIndex = 1

--loads the stuff we're gonna use in this game of WAR!!!
function love.load()
    --loads the image into the decksprite variable
    decksprite = love.graphics.newImage("cards.png")

    SPRITE_WIDTH, SPRITE_HEIGHT = 944, 385
    QUAD_WIDTH = 48
    QUAD_HEIGHT = 64
    quads = {} -- table for storing individual sprites

    --number of cards in a row
    --math.floor is used to return an integer
    cards_in_row = math.floor(SPRITE_WIDTH / QUAD_WIDTH)

    --loop to define quads
    for i = 1, 52 do --TODO: have we dealt with the empty space?

        --horizontal position of a card texture
        local x = ((i - 1) % cards_in_row) * QUAD_WIDTH
        --now we derive the vertical position of a card texture
        --((i - 1) / cards_in_row) calculates how many rows have passed, returns integer
        local y = math.floor((i - 1) / cards_in_row) * QUAD_HEIGHT
        --the graphic of a particular card[i] is calculated using the x and y variables
        quads[i] = love.graphics.newQuad(x, y, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)

--[[ 
        --value, suit, and spriteIndex sorted by rank (e.g. `spades` beats `hearts` beats `diamonds` beats `clubs`)
        local deck = {
            {value = "A", suit = "Spades", spriteIndex = 1},  -- Ace of Spades
            {value = "A", suit = "Hearts", spriteIndex = 2},  -- Ace of Hearts
            {value = "A", suit = "Diamonds", spriteIndex = 3}, -- Ace of Diamonds
            {value = "A", suit = "Clubs", spriteIndex = 4},   -- Ace of Clubs
            {value = "K", suit = "Spades", spriteIndex = 5},   -- King of Spades
            {value = "K", suit = "Hearts", spriteIndex = 6},   -- King of Hearts
            {value = "K", suit = "Diamonds", spriteIndex = 7}, -- King of Diamonds
            {value = "K", suit = "Clubs", spriteIndex = 8},   -- King of Clubs
            {value = "Q", suit = "Spades", spriteIndex = 9},   -- Queen of Spades
            {value = "Q", suit = "Hearts", spriteIndex = 10},  -- Queen of Hearts
            {value = "Q", suit = "Diamonds", spriteIndex = 11}, -- Queen of Diamonds
            {value = "Q", suit = "Clubs", spriteIndex = 12},  -- Queen of Clubs
            {value = "J", suit = "Spades", spriteIndex = 13},  -- Jack of Spades
            {value = "J", suit = "Hearts", spriteIndex = 14},  -- Jack of Hearts
            {value = "J", suit = "Diamonds", spriteIndex = 15}, -- Jack of Diamonds
            {value = "J", suit = "Clubs", spriteIndex = 16},  -- Jack of Clubs
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
    } ]]


    end 
end


function love.update()
    currentQuadIndex = currentQuadIndex + 1
    love.timer.sleep(1) -- this makes a gif possible (e.g. each card is displayed for 1 second each, rather than once per frame)
end


--draws the stuff we loaded
function love.draw()
        --if currentQuadIndex >= 1 
        love.graphics.draw(decksprite, quads[currentQuadIndex], 0, 0)
        love.graphics.print("Hello War", 350, 300)

    
end



--[[

function deal()
    for i,v in ipairs(deck) do
        if i % 2 == 0 then
            p1hand = {unpack(deck)}
            print("Player1 is dealt one card")
        else
            p2hand = {unpack(deck)}
            print("Player2 is dealt one card")
        end
    end
end

--[[ --war logic
function war()
	player1Hand[0] goes face down

function love.update(dt)
    --
end
    
end
 ]]

--stuff to build
-- deck
-- two players -> each player's hand -> table
-- take turns putting cards in the middle to compare -> if statements
-- shuffle cards -> add some random



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