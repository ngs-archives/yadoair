package org.ngsdev.widgets.yado {
	import flash.display.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.airutil.*;
	import flash.events.*;
	public class Yado extends Sprite {
		var base:Base;
		var jws:JWS;
		public function Yado() {
			base = new YadoBase();
			jws = new JWS("leo11111317351");
			jws.addEventListener("onInit",function(e:Event){ onJWSInit(); })
			addChild(this.base);
			base.init();
			//WindowPosition.init();
		}
		private function onJWSInit() {
			trace("onJWSInit");
		}
	}
}