package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.events.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class Yado extends Sprite {
		var base:Base;
		var jws:JWS;
		var select_region:SelectArea, select_pref:SelectArea, select_larea:SelectArea, select_sarea:SelectArea
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
			select_region = new SelectArea();
			select_region.appendButtons(jws.getAreaMaster().regions,"region");
			addChild(select_region);
		}
	}
}