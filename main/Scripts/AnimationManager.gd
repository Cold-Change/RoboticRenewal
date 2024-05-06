extends Node2D
@export var actor: Node

func _on_animation_player_animation_started(anim_name):
	if anim_name == "idle":
		$LeftArm.animation = "Idle"
		$Body.animation = "Idle"
		if actor.head == 1:
			$Head.animation = "IdleEnemy1"
		elif actor.head == 2:
			$Head.animation = "IdleEnemy2"
		elif actor.head == 3:
			$Head.animation = "IdleEnemy3"
		else:
			$Head.animation = "IdleRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "IdleBasic"
		else:
			$Legs.animation = "IdleWheels"
		if actor.arm == "Knife":
			$RightArm.visible = true
			$RightArm.animation = "IdleKnife"
		elif actor.arm == "Chainsaw":
			$RightArm.visible = true
			$RightArm.animation = "IdleChainsaw"
		else:
			$RightArm.visible = false
	elif anim_name == "walk":
		$LeftArm.animation = "Walk"
		$Body.animation = "Walk"
		if actor.head == 1:
			$Head.animation = "WalkEnemy1"
		elif actor.head == 2:
			$Head.animation = "WalkEnemy2"
		elif actor.head == 3:
			$Head.animation = "WalkEnemy3"
		else:
			$Head.animation = "WalkRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "WalkBasic"
		else:
			$Legs.animation = "WalkWheels"
		if actor.arm == "Knife":
			$RightArm.visible = true
			$RightArm.animation = "WalkKnife"
		elif actor.arm == "Chainsaw":
			$RightArm.visible = true
			$RightArm.animation = "WalkChainsaw"
		else:
			$RightArm.visible = false
	elif anim_name == "jab1" or anim_name == "jab2" or anim_name == "jab3":
		$LeftArm.animation = "Jab"
		$Body.animation = "Jab"
		if actor.head == 1:
			$Head.animation = "JabEnemy1"
		elif actor.head == 2:
			$Head.animation = "JabEnemy2"
		elif actor.head == 3:
			$Head.animation = "JabEnemy3"
		else:
			$Head.animation = "JabRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "JabBasic"
		else:
			$Legs.animation = "JabWheels"
		if actor.arm == "Knife":
			$RightArm.visible = true
			$RightArm.animation = "JabKnife"
		elif actor.arm == "Chainsaw":
			$RightArm.visible = true
			$RightArm.animation = "JabChainsaw"
		else:
			$RightArm.visible = false
	elif anim_name == "chainsaw1" or anim_name == "chainsaw2" or anim_name == "chainsaw3":
		$LeftArm.animation = "ChainsawAttack"
		$Body.animation = "ChainsawAttack"
		if actor.head == 1:
			$Head.animation = "ChainsawAttackEnemy1"
		elif actor.head == 2:
			$Head.animation = "ChainsawAttackEnemy2"
		elif actor.head == 3:
			$Head.animation = "ChainsawAttackEnemy3"
		else:
			$Head.animation = "ChainsawAttackRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "ChainsawAttackBasic"
		else:
			$Legs.animation = "ChainsawAttackWheels"
		$RightArm.visible = true
		$RightArm.animation = "ChainsawAttack"
	elif anim_name == "knife1" or anim_name == "knife2" or anim_name == "knife3":
		$LeftArm.animation = "KnifeAttack"
		$Body.animation = "KnifeAttack"
		if actor.head == 1:
			$Head.animation = "KnifeAttackEnemy1"
		elif actor.head == 2:
			$Head.animation = "KnifeAttackEnemy2"
		elif actor.head == 3:
			$Head.animation = "KnifeAttackEnemy3"
		else:
			$Head.animation = "KnifeAttackRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "KnifeAttackBasic"
		else:
			$Legs.animation = "KnifeAttackWheels"
		$RightArm.visible = true
		$RightArm.animation = "KnifeAttack"
	elif anim_name == "getup":
		$LeftArm.animation = "Fall"
		$Body.animation = "Fall"
		if actor.head == 1:
			$Head.animation = "FallEnemy1"
		elif actor.head == 2:
			$Head.animation = "FallEnemy2"
		elif actor.head == 3:
			$Head.animation = "FallEnemy3"
		else:
			$Head.animation = "FallRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "FallBasic"
		else:
			$Legs.animation = "FallWheels"
		if actor.arm == "Knife":
			$RightArm.visible = true
			$RightArm.animation = "FallKnife"
		elif actor.arm == "Chainsaw":
			$RightArm.visible = true
			$RightArm.animation = "FallChainsaw"
		else:
			$RightArm.visible = false
	elif anim_name == "getup":
		$LeftArm.animation = "Getup"
		$Body.animation = "Getup"
		if actor.head == 1:
			$Head.animation = "GetupEnemy1"
		elif actor.head == 2:
			$Head.animation = "GetupEnemy2"
		elif actor.head == 3:
			$Head.animation = "GetupEnemy3"
		else:
			$Head.animation = "GetupRoomie"
		if actor.legs == "Basic":
			$Legs.animation = "GetupBasic"
		else:
			$Legs.animation = "GetupWheels"
		if actor.arm == "Knife":
			$RightArm.visible = true
			$RightArm.animation = "GetupKnife"
		elif actor.arm == "Chainsaw":
			$RightArm.visible = true
			$RightArm.animation = "GetupChainsaw"
		else:
			$RightArm.visible = false
	
