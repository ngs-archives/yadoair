package org.ngsdev.widgets.yado {
	import flash.display.*;
	import flash.events.*;
	import fl.motion.easing.*;
	import org.as3s.Tween;
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.search.*;
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
			jws.addEventListener(JWS.AREAS_INIT,onJWSInit);
			jws.getAreas();
			//WindowPosition.init();
		}
		private function onJWSInit(e:Event=null) {
			jws.removeEventListener(JWS.AREAS_INIT,onJWSInit);
			showList(jws.areaMaster.regions,0)
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
		public function showYados() {
			trace(_hier[0].code,_hier[1].code,_hier[2].code,_hier[3].code)
			trace(_hier[0].areaname,_hier[1].areaname,_hier[2].areaname,_hier[3].areaname)
			var opt:YadoSearchParam = new YadoSearchParam({
				reg      : _hier[0]&&!_hier[1] ? _hier[0].code : "",
				pref     : _hier[1]&&!_hier[2] ? _hier[1].code : "",
				l_area  : _hier[2]&&!_hier[3] ? _hier[2].code : "",
				s_area : _hier[3] ? _hier[3].code : "",
				xml_ptn : "2"
			});
			jws.addEventListener(JWS.GET_YADOS,onGetYados);
			jws.getYados(opt);
		}
		private function onGetYados(e:Event=null) {
			jws.removeEventListener(JWS.GET_YADOS,onGetYados);
			trace(jws.yadoSearch.results.length);
			for each(var y:YadoResult in jws.yadoSearch.results) {
				trace(y.getPosition(),y.address)
			}
		}
	}
}