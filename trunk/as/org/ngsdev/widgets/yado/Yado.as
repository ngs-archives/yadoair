package org.ngsdev.widgets.yado {
	import flash.display.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.airutil.*;
	public class Yado extends Sprite {
		var base:Base;
		var jws:JWS;
		public function Yado() {
			this.base = new YadoBase();
			this.jws = new JWS("leo11111317351");
			this.addChild(this.base);
			this.base.init();
			//WindowPosition.init();
		}
	}
}