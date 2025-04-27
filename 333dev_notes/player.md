
### player: character2d


### player animations: AnimatedSprite2D

select "New SpriteFrames"

![[Pasted image 20250427162636.png]]

#### set grids 
here is:
horizontal: 20 
vertical: 8

![[Pasted image 20250427162334.png]]


when imported, it will look burry at first

![[Pasted image 20250427162910.png]]

go to project setting > Rendering > Textures
change texture filter to "Nearest"

![[Pasted image 20250427163030.png]]

it should now look clearer

![[Pasted image 20250427163138.png]]


#### assign collision shape

![[Pasted image 20250427165256.png]]

function to control player movement with according inputs

![[Pasted image 20250427165743.png]]


illustration of how direction input is interpreted for diagonal movement
x and y will have value of +/- 0.707

![[Pasted image 20250427172052.png]]


