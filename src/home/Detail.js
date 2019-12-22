import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    Button
} from 'react-native'

export default class Detail extends Component {

    static navigationOptions = ({navigation, navigationOptions}) => {
        return {
            title: navigation.getParam('title', '详情'),
            headerLeft: (
                <Button
                    title='返回'
                    color={navigationOptions.headerStyle.backgroundColor}
                    onPress={() => navigation.goBack()}
                />
            ),
            headerRight: (
                <View style={{flexDirection: 'row'}}>
                    <Button
                        title='Info'
                        color={navigationOptions.headerStyle.backgroundColor}
                        onPress={() => alert('This is a button!')}
                    />
                    <Button
                        title='😄'
                        color={navigationOptions.headerStyle.backgroundColor}
                        onPress={() => alert('This is a 😄!')}
                    />
                </View>
                
            ),
            headerStyle: {
                backgroundColor: navigationOptions.headerTintColor
            },
            headerTintColor: navigationOptions.headerStyle.backgroundColor
        }
    }

    gotoDetail = () => {
        this.props.navigation.push('Third')
    }

    changeTitle = () => {
        this.props.navigation.setParams({title: '修改后的title'})
    }

    render() {
        const { navigation } = this.props
        const itemId = navigation.getParam('itemId', 2)
        const itemName = navigation.getParam('itemName', '橘子')
        const itemDesc = navigation.getParam('itemDesc', '这是一种水果')
        return (
            <View style={styles.container}>
                <Text>详情页</Text>
                <Text>id:{itemId}</Text>
                <Text>name:{itemName}</Text>
                <Text>desc:{itemDesc}</Text>
                <Button
                    title='Go to Third'
                    onPress={this.gotoDetail}
                />
                <Button
                    title='Change title'
                    onPress={this.changeTitle}
                />
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'red',
        justifyContent: 'center',
        alignItems: 'center'
    }
})