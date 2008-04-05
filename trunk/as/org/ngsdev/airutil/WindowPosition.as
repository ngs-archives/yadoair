package org.ngsdev.airutil {
	import org.ngsdev.airutil.*;
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.geom.Rectangle;
	public class WindowPosition {
		private static var _filename:String = "window.txt";
		private static var _window:NativeWindow = new NativeWindow(new NativeWindowInitOptions	());
		public static function init(fn:String="") {
			if(fn) _filename = fn;
			var pos:Array = LocalFile.read(fn).split(",");
			if(!pos[0]) return;
			for(var i:String in pos) pos[i] = parseInt(pos[i]);
			if(!win.resizable) {
				pos[2] = win.width;
				pos[3] = win.height;
			}
			_window.bounds = new Rectangle(pos[0],pos[1],pos[2],pos[3]);
		}
		public static function save() {
			var win:NativeWindow = _window;
			var d:String = [win.x,win.y].join(",")
			if(win.resizable) d += [win.width,win.height].join(",");
			LocalFile.write(_filename,d);
		}
		public static function startMove() {
			var win:NativeWindow = _window;
			win.stage.addEventListener(MouseEvent.MOUSE_UP, onStopMove);
			win.startMove();
		}
		private static function onStopMove() {
			save();
		}
	}
}