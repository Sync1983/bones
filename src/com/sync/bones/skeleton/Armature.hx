package com.sync.bones.skeleton;

/**
 * ...
 * @author Sync
 */
class Armature
{
	public var name:String;
	
	public function new(armature:Xml) {
		name = armature.get('name');
		trace(this.name);
		trace(armature);
	}
	
}