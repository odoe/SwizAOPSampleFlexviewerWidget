package widgets.swizaopsamples.events
{
	import flash.events.Event;
	
	public class MapDetailsEvent extends Event
	{
		public static const LOAD_SERVICES_REQUEST:String = "loadServices";
		
		public var url:String;
		
		public function MapDetailsEvent( type:String )
		{
			super( type, true );
		}
	}
}