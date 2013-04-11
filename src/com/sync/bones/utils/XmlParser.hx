package com.sync.bones.utils;

import com.sync.bones.skeleton.ArmatureCollection;
import com.sync.bones.utils.BytesType;
import nme.utils.ByteArray;

/**
 * ...
 * @author Sync
 */
class XmlParser {
	private var _asset:ByteArray;
	private var _skelet:Xml;
	private var _texture:Xml;
	private var _arCollection:ArmatureCollection;
	
	public function new(data:ByteArray) {
		_arCollection =  new ArmatureCollection();
		
		_asset = data;
		
		switch(BytesType.getType(_asset)) {
			case BytesType.SWF, BytesType.PNG, BytesType.JPG:
				_asset.position 	=	_asset.length - 4;				
				var strSize:Int 	= _asset.readInt();
				var position:Int	= _asset.length - 4 - strSize;
				var xmlBytes:ByteArray = new ByteArray();				
				xmlBytes.writeBytes(_asset, position, strSize);				
				xmlBytes.uncompress();
				_skelet = Xml.parse(xmlBytes.readUTFBytes(xmlBytes.length));				
				xmlBytes.clear();
				_asset.position = position - 4;
				strSize = _asset.readInt();
				xmlBytes.writeBytes(_asset, position - 4 - strSize, strSize);
				xmlBytes.uncompress();
				_texture = Xml.parse(xmlBytes.readUTFBytes(xmlBytes.length));
				_asset.length = position - 4 - strSize;				
				this.decompres();				
			case BytesType.ZIP: throw "Can not decompress zip!";
			default: throw "Unknow format";
		}
	}
	
	private function decompres() {
		//trace(_skelet);
		for (skeletons in _skelet.elements())	
			for (node in skeletons.elements())
				switch(node.nodeName) {
					case "armatures":
							_arCollection.push(node);
				};
				
		//_skCollection = new SkeletCollection(node);	
			//trace(node.);
		
		//trace(_skelet);
		//trace(_texture);
	}
	
}