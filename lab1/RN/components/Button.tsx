import React from 'react'
import { TouchableOpacity, Text , StyleSheet} from 'react-native'

const Button = () => {
    return (
        <TouchableOpacity onPress={() => console.log('pressed')} style={styles.btn}>
            <Text style={styles.txt}>
                BUTTON
            </Text>
        </TouchableOpacity>
    )
}

export default Button

const styles = StyleSheet.create({
    btn: {
        backgroundColor: '#d6d7d7',
        padding: 10,
        borderRadius:4,
        marginBottom:14
    },
    txt: {
        color:"#222222",
        fontWeight:"bold"
    }
})
