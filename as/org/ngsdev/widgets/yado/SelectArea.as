package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class SelectArea extends MovieClip {
		private var _type:String;
		public var buttons:Array;
		public var selected:AreaButton;
		public function SelectArea() {
		}
		public function appendButtons(list:Array,t:String):void {
			_type = t;
			buttons = [];
			var b:AreaButton;
			var tgy:Number = 0;
			for each (var l:Area in list) {
				b = new AreaButton1();
				b.selectArea = this;
				b.setArea(l);
				b.y = tgy;
				tgy += b.height + 2;
				addChild(b);
				buttons.push(b);
			}
		}
		public function get type():String {
			return _type;
		}
		public function get code():String {
			return selected&&selected.code?selected.code:"";
		}
		public function get areaname():String {
			return selected&&selected.areaname?selected.areaname:"";
		}
	}
}