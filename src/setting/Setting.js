import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    Button
} from 'react-native'

export default class Setting extends Component {

    static navigationOptions = {
        title: '设置'
    }

    gotoProfile = () => {
        this.props.navigation.push('Profile')
    }

    render() {
        return (
            <View style={styles.container}>
                <Text>设置页</Text>
                <Button
                    title='Go to Profile'
                    onPress={this.gotoProfile}
                />
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'blue',
        justifyContent: 'center',
        alignItems: 'center'
    }
})