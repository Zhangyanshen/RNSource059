import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    TouchableOpacity,
    Button,
    NativeModules
} from 'react-native'

export default class Home extends Component {

    static navigationOptions = ({navigation, navigationOptions}) => {
        return {
            title: '首页',
            // headerTitle: () => {
            //     return (
            //         <View>
            //             <Text>首页</Text>
            //         </View>
            //     )
            // }
        }
        
    }

    gotoDetail = () => {
        this.props.navigation.push('Detail', {
            itemId: 1,
            itemName: '苹果🍎'
        })
    }

    showLogView = () => {
        NativeModules.LogModule.showLogView()
    }

    addLog = () => {
        const obj = {
            key1: 123,
            key2: 'aaa',
            key3: '傻逼🐶',
            key4: [1, '234', '傻逼🐯', undefined, null],
            key5: {
                '1': 12
            }
        }
        // console.error('你是我的眼', obj)
        console.warn('你是我的眼', obj)
        console.error('你是我的眼', obj)
    }

    render() {
        return (
            <View style={styles.container}>
                <Text>主页</Text>
                <Button
                    title='Go to Detail'
                    onPress={this.gotoDetail}
                />
                <TouchableOpacity activeOpacity={.8} onPress={this.showLogView}>
                    <Text style={styles.btn}>{'显示log'}</Text>
                </TouchableOpacity>
                <TouchableOpacity activeOpacity={.8} onPress={this.addLog}>
                    <Text style={styles.btn}>{'添加log'}</Text>
                </TouchableOpacity>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'green',
        justifyContent: 'center',
        alignItems: 'center'
    },
    btn: {
        color: 'blue'
    }
})