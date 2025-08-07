import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { LLog, LynxEnv, LynxServiceCenter, LynxServiceType } from '@lynx/lynx';
import { LynxDevToolService } from '@lynx/lynx_devtool_service';
import { LynxLogService } from '@lynx/lynx_log_service';
import { LynxHttpService } from '@lynx/lynx_http_service';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    // Init LynxService start
    LynxServiceCenter.registerService(LynxServiceType.DevTool, LynxDevToolService.instance);
    LynxServiceCenter.registerService(LynxServiceType.Http, LynxHttpService.instance);
    LynxServiceCenter.registerService(LynxServiceType.Log, LynxLogService.instance);
    // Init LynxService end
    // Init LynxEnv start
    LLog.useSysLog(true);
    LynxEnv.initialize(this.context);
    let options = new Map<string, string>();
    options.set('App', 'LynxExplorer');
    options.set('AppVersion', '0.0.1');
    LynxEnv.setAppInfo(options);
    LynxEnv.enableDevtool(true);
    // Init LynxEnv end
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}