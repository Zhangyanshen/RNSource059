import React, { Component } from 'react'
import {
    View,
    Text,
    StyleSheet,
    Button
} from 'react-native'

export default class Third extends Component {

    static navigationOptions = {
        title: 'Third'
    }

    gotoHome = () => {
        this.props.navigation.popToTop()
    }

    render() {
        return (
            <View style={styles.container}>
                <Text>第三个页面</Text>
                <Button
                    title='Go to Home'
                    onPress={this.gotoHome}
                />
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'black',
        justifyContent: 'center',
        alignItems: 'center'
    }
})