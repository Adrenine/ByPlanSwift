//
//  AppNotification.swift
//  KommanderTouPing
//
//  Created by Kystar's Mac Book Pro on 2020/4/1.
//  Copyright © 2020 kystar. All rights reserved.
//

import Foundation

extension Notification.Name {
    // MARK: - ---- 认证
    struct Authentication {
        //认证成功
        static let authenticationSuccessNotification = Notification.Name.init("kAuthenticationSuccessNotification")
        //认证失败
        static let authenticationFailNotification = Notification.Name.init("kAuthenticationFailNotification")
        //切换认证成功
        static let switchAuthenticationSuccessNotification = Notification.Name.init("kSwitchAuthenticationSuccessNotification")
        //切换认证失败
        static let switchAuthenticationFailNotification = Notification.Name.init("kSwitchAuthenticationFailNotification")
    }
    
    // 设备列表
    struct DeviceList {
        static let historyListChangeNotification = Notification.Name.init("kHistoryListChangeNotification")
        static let addDeviceToHistoryListNotification = Notification.Name.init("kAddDeviceToHistoryListNotification")
        static let deleteDeviceFromeHistoryListNotification = Notification.Name.init("kDeleteDeviceFromeHistoryListNotification")
        static let deviceListChangeNotification = Notification.Name.init("kDeviceListChangeNotification")
        static let addDeviceToDeviceListNotification = Notification.Name.init("kAddDeviceToDeviceListNotification")
        static let deleteDeviceFromDeviceListNotification = Notification.Name.init("kDeleteDeviceFromDeviceListNotification")
    }
    
    // MARK: - ---- 连接
    struct Connection {
        //密码错误
        static let errorPasswordNotification = Notification.Name.init("kErrorPasswordNotification")
        //设备连接错误
        static let connectDeviceErrorNotification = Notification.Name.init("kConnectDeviceErrorNotification")
        //设备连接失败
        static let connectDeviceFailNotification = Notification.Name.init("kConnectDeviceFailNotification")
        //当前已存在存在连接设备
        static let existDeviceConnectNotification = Notification.Name.init("kExistDeviceConnectNotification")
    }
    
    // MARK: - ---- 节目编辑
    struct Kommander {
        //节目文件列表收到数据
        static let fileListArrayHasDataNotification = Notification.Name.init("kFileListArrayHasDataNotification")
        //画布位置收到数据
        static let canvasViewAndPlayViewSizeNotEmptyNotification = Notification.Name.init("kCanvasViewAndPlayViewSizeNotEmptyNotification")
        //节目文件位置改变
        static let programFileLocationChangedNotification = Notification.Name.init("kProgramFileLocationChangedNotification")
        //当前选中文件的位置或大小改变
        static let dragLayerViewProgramFileLocationOrSizeChangedNotification = Notification.Name.init("kDragLayerViewProgramFileLocationOrSizeChangedNotification")
        //当前存在抽奖
        static let currentExistLuckDrawNotification = Notification.Name.init("kCurrentExistLuckDrawNotification")
        //当前不存在抽奖
        static let currentNotExistLuckDrawNotification = Notification.Name.init("kCurrentNotExistLuckDrawNotification")
        //当前存在Office
        static let currentExistOfficeNotification = Notification.Name.init("kCurrentExistOfficeNotification")
        //当前不存在Office
        static let currentNotExistOfficeNotification = Notification.Name.init("kCurrentNotExistOfficeNotification")
        //收到非当前请求的Udp包
        static let receiveOtherUdpDataNotification = Notification.Name.init("kReceiveOtherUdpDataNotification")
        //选中view的frame变化
        static let selectViewFrameChangeNotification = Notification.Name.init("kKSSelectViewFrameChangeNotification")
        //选中view的frame变化需要发送命令
        static let frameChangeNeedSendCmdToServerNotification = Notification.Name.init("kFrameChangeNeedSendCmdToServerNotification")
        //拖拽信号源视图到输出视图上
        static let dragSignalViewToOutputViewNotification = Notification.Name.init("dragSignalViewToOutputView")
        //双击信号源视图切换信号源
        static let doubleClickSignalViewChangeSignalNotification = Notification.Name.init("doubleClickChangeSignal")
    }
}
