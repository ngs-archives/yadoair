package org.ngsdev.widgets.yado {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import com.afcomponents.umap.core.UMap;
	import com.afcomponents.umap.providers.google.GoogleProvider;
	import com.afcomponents.umap.types.LatLng;
	import sandbox.umaptest.*;
	public class Map extends UMap {
		public function Map() {
			var settings:URLRequest = new URLRequest("http://www.afcomponents.com/components/g_map_as3/settings.xml?rand=" + Math.random());
			var language:URLRequest = new URLRequest("http://maps.google.com/maps?file=api&v=2") 
			var copyright:URLRequest = new URLRequest("http://www.afcomponents.com/proxy/g_map_as3/copyright.php");
			control.provider = new GoogleProvider(false, settings, language, copyright);
			setSize(500,300);
			y = 300;
			addControl(Yado.self.ctrl);
		}
		public function prot(xpos:Number,ypos:Number):Pin {
			var pos:LatLng = new LatLng(xpos,ypos);
			setCenter(pos);
			var pin:Pin = new Pin();
			pin.position = pos;
			addOverlay(pin);
			return pin;
		}
	}
}