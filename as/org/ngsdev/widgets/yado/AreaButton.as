package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import org.ngsdev.airutil.*;
	import org.ngsdev.widgets.yado.*;
	public class AreaButton extends MovieClip {
		private var _area:Area;
		public function AreaButton() {
		}
		public function setArea(a:Area) {
			_area = a;
			name_tf.text = a.name;
			addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:Event) {
			var nt:int = _area.type+1;
			Yado.self.showList(_area.areas,nt)
		}
	}
}