// ActionScript file

import info.knightrcom.state.BaseStateManager;
import info.knightrcom.state.FightLandlordGameStateManager;
import info.knightrcom.state.LobbyStateManager;
import info.knightrcom.state.LoginStateManager;
import info.knightrcom.state.PushdownWinGameStateManager;
import info.knightrcom.state.QiongWinGameStateManager;
import info.knightrcom.state.Red5GameStateManager;
import info.knightrcom.util.BrowserAddressUtil;
import info.knightrcom.util.PuppetEngine;
import info.knightrcom.GameSocketProxy;

import mx.core.Application;
import mx.events.FlexEvent;
import mx.utils.URLUtil;

/**
 * 
 * @param event
 */
protected override function applicationCompleteHandler(event:FlexEvent):void {
    var myApp:CCGameClient = application as CCGameClient;
    if (!this._launchInfo.remoteAddr) {
        this._launchInfo.remoteAddr = URLUtil.getServerName(Application.application.loaderInfo.url);
    }
    var socketProxy:GameSocketProxy = new GameSocketProxy(this._launchInfo.remoteAddr, 2009);
    // 基础状态管理器
    var baseStateManager:BaseStateManager = new BaseStateManager(socketProxy);
    // 登录状态管理器
    var loginStateManager:LoginStateManager = new LoginStateManager(socketProxy, myApp.loginState);
    // 大厅状态管理器
    var lobbyStateManager:LobbyStateManager = new LobbyStateManager(socketProxy, myApp.lobbyState);
    // 红五状态管理器
    var red5GameStateManager:Red5GameStateManager = new Red5GameStateManager(socketProxy, myApp.red5GameState);
    // 斗地主状态管理器
    var fightLandlordGameStateManager:FightLandlordGameStateManager = new FightLandlordGameStateManager(socketProxy, myApp.fightLandlordGameState);
    // 推到胡状态管理器
    var pushdownWinGameStateManager:PushdownWinGameStateManager = new PushdownWinGameStateManager(socketProxy, myApp.pushdownWinGameState);
    // 穷胡状态管理器
    var qiongWinGameStateManager:QiongWinGameStateManager = new QiongWinGameStateManager(socketProxy, myApp.qiongWinGameState);
    baseStateManager.init();
    // 全屏效果
    // PlatformRepresentationUtil.toggleStageDisplayState(Application.application.stage);
    // login the platform through a unique identifier
    
    // 设置PUPPET入口
    var securityPassword:String = null;
    var classPrefix:String = null;
    var username:String = null;
    var password:String = null;
    var roomId:String = null;
    var gameType:String = null;
    // URL入口
    securityPassword = BrowserAddressUtil.getParameterValue("securityPassword");
    classPrefix = BrowserAddressUtil.getParameterValue("classPrefix");
    username = BrowserAddressUtil.getParameterValue("username");
    password = BrowserAddressUtil.getParameterValue("password");
    roomId = BrowserAddressUtil.getParameterValue("roomId");
    gameType = BrowserAddressUtil.getParameterValue("gameType"); // 判别游戏类型
    if (securityPassword &&
        classPrefix &&
        username &&
        password &&
        roomId/* &&
        gameType*/) {
        red5GameStateManager.myPuppet = PuppetEngine.createPinocchioPuppet(
            securityPassword, classPrefix, username, password, roomId);
        return;
    }
    // LAUNCHER入口
    securityPassword = this._launchInfo.securityPassword;
    classPrefix = this._launchInfo.classPrefix;
    username = this._launchInfo.username;
    password = this._launchInfo.password;
    roomId = this._launchInfo.roomId;
    gameType = this._launchInfo.gameType; // 判别游戏类型
    if (securityPassword &&
        classPrefix &&
        username &&
        password &&
        roomId/* &&
        gameType*/) {
        red5GameStateManager.myPuppet = PuppetEngine.createPinocchioPuppet(
            securityPassword, classPrefix, username, password, roomId);
        return;
    }
}