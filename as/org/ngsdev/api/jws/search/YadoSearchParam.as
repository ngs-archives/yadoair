package org.ngsdev.api.jws.search {
	import flash.events.EventDispatcher;
	public class YadoSearchParam extends EventDispatcher {
		private var _params:Object = {};
		[ArrayElementType("String")]
		protected static var keys = ["reg", "pref", "l_area", "s_area",
			"h_id", "o_area_id", "o_id", "x", "y", "range", "h_name", "h_type",
			"o_pool", "parking", "pub_bath", "onsen", "prv_bath", "v_bath", "sauna",
			"jacz", "mssg", "r_ski", "r_brd", "pet", "esthe", "p_pong", "limo", "room_b",
			"room_d", "prv_b", "prv_d", "early_in", "late_out", "no_smk", "net", "r_room",
			"high", "p_ok", "sp_room", "bath_to", "o_bath", "pour", "cloudy", "i_pool",
			"fitness", "gym", "p_field", "bbq", "hall", "5_station", "5_beach", "5_slope",
			"c_card", "c_jcb", "c_visa", "c_master", "c_amex", "c_uc", "c_dc", "c_nicos",
			"c_diners", "c_saison", "c_ufj", "cvs", "no_meal", "b_only", "d_only", "2_meals",
			"sng_room", "twn_room", "dbl_room", "tri_room", "4bed_room", "jpn_room",
			"j_w_room", "child_price", "c_bed_meal", "c_no_bed_meal", "c_meal_only",
			"c_bed_only", "pict_size", "picts", "order", "start", "count", "xml_ptn"];
		function YadoSearchParam(prm) {
			for(var i in prm) setParam(i,prm[i]);
		}
		public function setParam(k:String,v:String):Boolean {
			for each (var ke:String in keys) {
				if(ke == k) {
					_params[k] = v;
					return true;
				}
			}
			return false;
		}
		public function getParam(k:String):String {
			return _params[k]?_params[k]:"";
		}
		public function get queryString():String {
			var ret:String = "";
			for(var i in _params) ret += i+"="+_params[i]+"&";
			return ret;
		}
	}
}