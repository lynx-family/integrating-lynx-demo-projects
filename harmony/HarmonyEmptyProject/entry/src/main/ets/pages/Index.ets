import {
  LynxTemplateResourceFetcher,
  LynxMediaResourceFetcher,
  LynxGenericResourceFetcher,
  LynxView,
} from '@lynx/lynx';

import { ExampleTemplateResourceFetcher } from '../provider/ExampleTemplateResourceFetcher';
import { ExampleMediaResourceFetcher } from '../provider/ExampleMediaResourceFetcher';
import { ExampleGenericResourceFetcher } from  '../provider/ExampleGenericResourceFetcher';

@Entry
@Component
struct Index {
  templateResourceFetcher: LynxTemplateResourceFetcher = new ExampleTemplateResourceFetcher();
  mediaResourceFetcher: LynxMediaResourceFetcher = new ExampleMediaResourceFetcher();
  genericResourceFetcher: LynxGenericResourceFetcher = new ExampleGenericResourceFetcher();
  private url: string = 'main.lynx.bundle';

  build() {
    Column() {
      LynxView({
        templateResourceFetcher: this.templateResourceFetcher,
        mediaResourceFetcher: this.mediaResourceFetcher,
        genericResourceFetcher: this.genericResourceFetcher,
        url: this.url,
      }).width('100%').height('100%');
    }
    .size({ width: '100%', height: '100%' })
  }
}