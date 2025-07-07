import { LynxMediaResourceFetcher, LynxResourceRequest, LynxOptionalBool } from '@lynx/lynx';

export class ExampleMediaResourceFetcher extends LynxMediaResourceFetcher {
  shouldRedirectUrl(request: LynxResourceRequest): string {
    // just return the input url;
    return request.url;
  }

  isLocalResource(url: string): LynxOptionalBool {
    return LynxOptionalBool.UNDEFINED;
  }
}