package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Region extends Area {
		function Region(x:XML) {
			super(x);
			trace(x.name())
			for each (var pref:XML in x.Prefecture) {
				areas.push(new Prefecture(pref));
			}
		}
	}
}