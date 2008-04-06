package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class AreaButton extends MovieClip {
		public function AreaButton() {
		}
		public function setArea(a:Area) {
			trace(a.code,a.name)
			name_tf.text = a.name;
		}
	}
}