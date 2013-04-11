package com.sync.bones.skeleton;
import nme.Vector;
/**
 * ...
 * @author Sync
 */
class ArmatureCollection {
	private var _armatures:Array<Armature>;
	
	public function new() {
		_armatures = new Array<Armature>();	
	}
	
	public function push(armature:Xml) {
		for (node in armature.elements())
			_armatures.push(new Armature(node));		
	}
	
}