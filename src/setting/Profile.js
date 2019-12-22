import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    Button
} from 'react-native'

export default class Profile extends Component {

    static navigationOptions = {
        title: '头像'
    }

    render() {
        return (
            <View style={styles.container}>
                <Text>Profile页面</Text>
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