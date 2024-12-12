
--loads image into the texture variable
texture = love.graphics.newImage("cards.png")
    
--define card coordinates using newQuad function
--hearts
aceHeart = love.graphics.newQuad(0,0,63,77, texture)
oneHeart = love.graphics.newQuad(0,0,0,0, texture)
twoHeart = love.graphics.newQuad(0,0,0,0, texture)
threeHeart = love.graphics.newQuad(0,0,0,0, texture)
fourHeart = love.graphics.newQuad(0,0,0,0, texture)
fiveHeart = love.graphics.newQuad(0,0,0,0, texture)
sixHeart = love.graphics.newQuad(0,0,0,0, texture)
sevenHeart = love.graphics.newQuad(0,0,0,0, texture)
eightHeart = love.graphics.newQuad(0,0,0,0, texture)
nineHeart = love.graphics.newQuad(0,0,0,0, texture)
tenHeart = love.graphics.newQuad(0,0,0,0, texture)
jackHeart = love.graphics.newQuad(0,0,0,0, texture)
queenHeart = love.graphics.newQuad(0,0,0,0, texture)
kingHeart = love.graphics.newQuad(0,0,0,0, texture)
--diamonds
aceDiamond = love.graphics.newQuad(0,0,0,0, texture)
oneDiamond = love.graphics.newQuad(0,0,0,0, texture)
twoDiamond = love.graphics.newQuad(0,0,0,0, texture)
threeDiamond = love.graphics.newQuad(0,0,0,0, texture)
fourDiamond = love.graphics.newQuad(0,0,0,0, texture)
fiveDiamond = love.graphics.newQuad(0,0,0,0, texture)
sixDiamond = love.graphics.newQuad(0,0,0,0, texture)
sevenDiamond = love.graphics.newQuad(0,0,0,0, texture)
eightDiamond = love.graphics.newQuad(0,0,0,0, texture)
nineDiamond = love.graphics.newQuad(0,0,0,0, texture)
tenDiamond = love.graphics.newQuad(0,0,0,0, texture)
jackDiamond = love.graphics.newQuad(0,0,0,0, texture)
queenDiamond = love.graphics.newQuad(0,0,0,0, texture)
kingDiamond = love.graphics.newQuad(0,0,0,0, texture)
--spades
aceSpade = love.graphics.newQuad(0,0,0,0, texture)
oneSpade = love.graphics.newQuad(0,0,0,0, texture)
twoSpade = love.graphics.newQuad(0,0,0,0, texture)
threeSpade = love.graphics.newQuad(0,0,0,0, texture)
fourSpade = love.graphics.newQuad(0,0,0,0, texture)
fiveSpade = love.graphics.newQuad(0,0,0,0, texture)
sixSpade = love.graphics.newQuad(0,0,0,0, texture)
sevenSpade = love.graphics.newQuad(0,0,0,0, texture)
eightSpade = love.graphics.newQuad(0,0,0,0, texture)
nineSpade = love.graphics.newQuad(0,0,0,0, texture)
tenSpade = love.graphics.newQuad(0,0,0,0, texture)
jackSpade = love.graphics.newQuad(0,0,0,0, texture)
queenSpade = love.graphics.newQuad(0,0,0,0, texture)
kingSpade = love.graphics.newQuad(0,0,0,0, texture)
--clubs
aceClub = love.graphics.newQuad(0,0,0,0, texture)
oneClub = love.graphics.newQuad(0,0,0,0, texture)
twoClub = love.graphics.newQuad(0,0,0,0, texture)
threeClub = love.graphics.newQuad(0,0,0,0, texture)
fourClub = love.graphics.newQuad(0,0,0,0, texture)
fiveClub = love.graphics.newQuad(0,0,0,0, texture)
sixClub = love.graphics.newQuad(0,0,0,0, texture)
sevenClub = love.graphics.newQuad(0,0,0,0, texture)
eightClub = love.graphics.newQuad(0,0,0,0, texture)
nineClub = love.graphics.newQuad(0,0,0,0, texture)
tenClub = love.graphics.newQuad(0,0,0,0, texture)
jackClub = love.graphics.newQuad(0,0,0,0, texture)
queenClub = love.graphics.newQuad(0,0,0,0, texture)
kingClub = love.graphics.newQuad(0,0,0,0, texture)

--used later
local card, pos



--war logic
function war()
	player1Hand[0] goes face down


--play card
function playCard()
	if player1Card > player2Card then
		player1Hand = player1Hand + player2Card --add p2 card to p1 hand
	elseif player2Card > player1Card then
		player2Hand = player2Hand + player2Card
	elseif player1Card == player2Card do
		war()


function love.update(dt)
    --
end
    
--draws graphics on screen
function love.draw()
    love.graphics.draw(texture, aceHeart, 0, 0)
    
end


--stuff to build
-- deck
-- two players -> each player's hand -> table
-- take turns putting cards in the middle to compare -> if statements
-- shuffle cards -> add some random

