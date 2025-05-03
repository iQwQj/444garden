
#### use patch margin instead of dragging directly

![[Pasted image 20250503171423.png]]

if we try to resize the inventory bag by dragging:
![[Pasted image 20250503171601.png]]
it will look funky and the margins will be uneven.

instead, if we add patch margins to constraint it:
![[Pasted image 20250503171759.png]]
margins will now stay constant however you drag it.

### slots in the inventory

#### create new scene for slots
![[Pasted image 20250503172254.png]]

add in child Sprite2D and add texture of the inventory slot
disable "Centered" for easier alignment


go back to parent node
change self-modulate to transparent
layout Custom Minimum by copying "Transform" x and y values

![[Pasted image 20250503172607.png]]



instantiate 12 slots into the inventory container

![[Pasted image 20250503173212.png]]

it will first form a long line, we can adjust into columns:

![[Pasted image 20250503173137.png]]

![[Pasted image 20250503173301.png]]

