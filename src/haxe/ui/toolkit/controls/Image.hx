package haxe.ui.toolkit.controls;

import flash.display.Bitmap;
import flash.display.BitmapData;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.resources.ResourceManager;

/**
 General purpose image control
 **/
class Image extends Component {
	private var _bmp:Bitmap;
	private var _resource:String;
	
	public function new() {
		super();
		autoSize = true;
	}
	
	
	//******************************************************************************************
	// Overrides
	//******************************************************************************************
	private override function initialize():Void {
		super.initialize();
		
		if (_bmp != null) {
			sprite.addChild(_bmp);
			if (this.height > _bmp.height) {
				_bmp.y = Std.int((this.height / 2) - (_bmp.height / 2));
			}
		}
	}
	
	/**
	 Destroy the image and free the resources (will be called by the framework automatically)
	 **/
	public override function dispose():Void {
		if (_bmp != null) {
			_bmp.bitmapData.dispose();
			sprite.removeChild(_bmp);
			_bmp = null;
		}
		super.dispose();
	}
	
	//******************************************************************************************
	// Methods/props
	//******************************************************************************************
	/**
	 The resource asset for this image: eg `assets/myimage.jpeg`
	 **/
	public var resource(get, set):String;
	
	private function get_resource():String {
		return _resource;
	}
	
	private function set_resource(value:String):String {
		if (_bmp != null) {
			//_bmp.bitmapData.dispose();
			sprite.removeChild(_bmp);
			_bmp = null;
		}
		var bmpData:BitmapData = ResourceManager.instance.getBitmapData(value);
		if (bmpData != null) {
			_bmp = new Bitmap(bmpData);
			sprite.addChild(_bmp);
			if (autoSize == true) {
				this.width = bmpData.width;
				this.height = bmpData.height;
			}
		}
		_resource = value;
		return value;
	}
	
}