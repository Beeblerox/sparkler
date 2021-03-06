package sparkler.modules;

import sparkler.core.Particle;
import sparkler.core.ParticleData;
import sparkler.core.ParticleModule;
import sparkler.data.Vector;


class RadialSpawnModule  extends ParticleModule {


	public var radius:Float;
	var rnd_point:Vector;


	public function new(_options:RadialSpawnModuleOptions) {

		super(_options);

		radius = _options.radius != null ? _options.radius : 128;
		
		rnd_point = new Vector();

		_priority = -999;
		
	}

	override function onspawn(p:Particle) {

		var pd:ParticleData = emitter.show_particle(p);

		random_point_in_unit_circle();

		pd.x = emitter.system.position.x + emitter.position.x + rnd_point.x * radius;
		pd.y = emitter.system.position.y + emitter.position.y + rnd_point.y * radius;

	}

	override function onunspawn(p:Particle) {

		emitter.hide_particle(p);

	}

	inline function random_point_in_unit_circle() : Vector {

		var _r:Float = Math.sqrt( emitter.random() );
		var _t:Float = (-1 + (2 * emitter.random())) * 6.283185307179586; // two PI

		rnd_point.set_xy( (_r * Math.cos(_t)), (_r * Math.sin(_t)) );

		return rnd_point;

	}


// import/export

	override function from_json(d:Dynamic) {

		super.from_json(d);

		radius = d.radius;
		
		return this;
	    
	}

	override function to_json():Dynamic {

		var d = super.to_json();

		d.radius = radius;

		return d;
	    
	}


}


typedef RadialSpawnModuleOptions = {

	>ParticleModuleOptions,

	@:optional var radius:Float;

}


