package widgets.swizaopsamples.service
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	
	import widgets.swizaopsamples.model.vo.MapServiceItem;

	public class MapDetailsService
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		private var _service:HTTPService;

		public function MapDetailsService()
		{
			_service = new HTTPService();
		}
		
		public function loadServices( url:String ):AsyncToken
		{
			_service.url = url; // + "/?f=sitemap";
			_service.resultFormat = "text";
			//return _service.send();
			return _service.send( { f: "json", pretty: false } )
			//return _service.send( { f: "sitemap" } );
		}
		
		public function findServiceDetails( item:MapServiceItem ):AsyncToken
		{
			_service.url = item.url + "?f=json&pretty=false";
			_service.resultFormat = "text";
			return _service.send();
			//return _service.send( { f: "json", pretty: false } );
		}
	}
}
