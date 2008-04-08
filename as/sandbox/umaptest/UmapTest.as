package sandbox.umaptest {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import com.afcomponents.umap.core.UMap;
	import com.afcomponents.umap.providers.google.GoogleProvider;
	import com.afcomponents.umap.types.LatLng;
	public class UmapTest extends Sprite {
		function UmapTest() {
			var map:UMap = new UMap();
			var settings:URLRequest = new URLRequest("http://www.afcomponents.com/components/g_map_as3/settings.xml?rand=" + Math.random());
			var language:URLRequest = new URLRequest("http://maps.google.com/maps?file=api&v=2") 
			var copyright:URLRequest = new URLRequest("http://www.afcomponents.com/proxy/g_map_as3/copyright.php");
			map.control.provider = new GoogleProvider(false, settings, language, copyright);
			map.setSize(500,300);
			var pos:LatLng = new LatLng(35.63230874308344,139.70740566929535);
			map.setCenter(pos);
			map.addControl(ctrl);
			addChild(map)
			var pin:Pin = new Pin();
			pin.position = pos;
			map.addOverlay(pin);
		}
	}
}