/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';

import {
  createAppContainer,
  createStackNavigator,
  createBottomTabNavigator,
  createSwitchNavigator
} from 'react-navigation'

import Home from './src/home/Home'
import Detail from './src/home/Detail'
import Third from './src/home/Third'
import Setting from './src/setting/Setting'
import Profile from './src/setting/Profile'

// 导航栏样式
const defaultNavigationOptions = ({navigation}) => {
  return {
    headerStyle: {
      backgroundColor: '#f4511e'
    },
    headerTintColor: '#fff',
    headerTitleStyle: {
      fontWeight: 'bold',
      fontSize: 18
    }
  }
}

// // home
// const homeStackNav = createStackNavigator({
//   Home: {
//     screen: Home
//   },
//   Detail: {
//     screen: Detail
//   },
//   Third
// }, {
//   defaultNavigationOptions
// })

// // setting
// const settingStackNav = createStackNavigator({
//   Setting,
//   Profile
// }, {
//   defaultNavigationOptions
// })

// const appTabNav = createBottomTabNavigator({
//   homeStackNav,
//   settingStackNav
// }, {
//   tabBarOptions: {
//     activeTintColor: '#f4511e'
//   }
// })

const TabNavigator = createBottomTabNavigator({
  Home,
  Setting
}, {
  tabBarOptions: {
    activeTintColor: '#f4511e'
  }
})

const HomeStack = createStackNavigator({
  TabNavigator,
  Detail,
  Third,
  Profile
}, {
  defaultNavigationOptions
})

const AppContainer = createAppContainer(HomeStack)

export default class App extends Component {
  render() {
    return <AppContainer />
  }
}
