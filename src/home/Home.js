import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    TouchableOpacity,
    Button
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

    render() {
        return (
            <View style={styles.container}>
                <Text>主页</Text>
                <Button
                    title='Go to Detail'
                    onPress={this.gotoDetail}
                />
                {/* <TouchableOpacity activeOpacity={.8} onPress={this.gotoDetail}>
                    <Text style={styles.btn}>进入详情页</Text>
                </TouchableOpacity> */}
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