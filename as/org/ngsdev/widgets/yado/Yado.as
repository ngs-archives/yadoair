package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.events.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class Yado extends Sprite {
		public var base:Base;
		public var jws:JWS;
		public var select_region:SelectArea, select_pref:SelectArea, select_larea:SelectArea, select_sarea:SelectArea
		public static var self:Yado;
		private var _hier:Array;
		public function Yado() {
			self = this;
			base = new YadoBase();
			addChild(this.base);
			base.init();
			//
			_hier = [];
			jws = new JWS("leo11111317351");
			jws.addEventListener("onInit",function(e:Event){ onJWSInit(); })
			//WindowPosition.init();
		}
		private function onJWSInit() {
			showList(jws.getAreaMaster().regions,0)
		}
		public function showList(l:Array,n:int) {
			var ta:Array = ["region","pref","larea","sarea"];
			var t:String = ta[n];
			if(t) {
				for(var i:Number=n;i<_hier.length;i++) {
					if(_hier[i]) {
						removeChild(_hier[i]);
						delete _hier[i];
					}
				}
				var s:SelectArea = new SelectArea();
				s.appendButtons(l,t);
				s.x = 174 * n;
				addChild(s);
				_hier[n] = s; 
				this["select_"+t] = s;
			}
		}
	}
}