package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.events.*;
	import fl.motion.easing.*;
	import org.as3s.Tween;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class Yado extends Sprite {
		public var base:Base;
		public var jws:JWS;
		public var select_region:SelectArea, select_pref:SelectArea, select_larea:SelectArea, select_sarea:SelectArea
		public static var self:Yado;
		private var _hier:Array;
		private var tween:Tween;
		public var selects:Sprite;
		public function Yado() {
			self = this;
			stage.align = StageAlign.TOP_LEFT;
			base = new YadoBase();
			addChild(this.base);
			base.init();
			//
			selects = new Sprite();
			addChild(selects);
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
				for(var i:int=n;i<_hier.length;i++) {
					if(_hier[i]) {
						selects.removeChild(_hier[i]);
						delete _hier[i];
					}
				}
				var s:SelectArea = new SelectArea();
				s.appendButtons(l,t);
				selects.addChild(s);
				s.x = (s.width+2) * n;
				_hier[n] = s; 
				this["select_"+t] = s;
				focus(n);
			}
		}
		public function focus(i:int):void {
			if(_hier[i-2]) {
				tween = new Tween(selects,
					[{x:-_hier[i-2].x}, Tween.easing, 24]
				);
				tween.reset();
				tween.start();
			}
		}
	}
}