package org.ngsdev.api.jws.master {
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