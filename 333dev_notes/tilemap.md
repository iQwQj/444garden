#### important! configure layers

![[Pasted image 20250427174302.png]]

#### drag in sprite sheet to **TileSet 

![[Pasted image 20250427174740.png]]


looks like this when you finished:
![[Pasted image 20250427174938.png]]


add in terrain layer by layer

layer 1: grass
![[Pasted image 20250427175242.png]]

layer 2: cliffs
![[Pasted image 20250427175427.png]]

layer 3: trees

![[Pasted image 20250427175534.png]]


![[Pasted image 20250427180434.png]]

selecting multiple tiles can allow drawing all at once

![[Pasted image 20250427180611.png]]


for trees, be careful to check if they end at edges (see the wrong example on the right of the path)
![[Pasted image 20250427182537.png]]

tips for camera limit setting

create a Camera2D on World scene.
move the camera to the edge
it's Transform number would be the proper limit

![[Pasted image 20250427183208.png]]


go back and create a Camera2D in the Player scene, use this x = -479 as the left limit
![[Pasted image 20250427183413.png]]

repeat steps for y value
![[Pasted image 20250427183523.png]]


### if it does not work as expected, check the Zoom setting of Camera2D


![[Pasted image 20250427184103.png]]

it worked after changing the Zoom to 2.5 X
![[Pasted image 20250427184141.png]]




