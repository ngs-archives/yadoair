package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Region extends Area {
		function Region(x:XML) {
			super(x);
			type = 0;
			default xml namespace = new Namespace("jws");
			for each (var a:XML in x.Prefecture) {
				areas.push(new Prefecture(a));
			}
		}
	}
}