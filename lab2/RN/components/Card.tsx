import React from 'react'
import { View, Text ,StyleSheet} from 'react-native'

const Card = () => {
    return (
        <View style={styles.container}>
            <View style={styles.card}>

            </View>
        </View>
    )
}

export default Card

const styles = StyleSheet.create({
    container: {
        width:"100%",
        alignItems:"center"
    },
    card:{
        width:"70%", 
        height:150,
        backgroundColor:"green",
        marginTop:-30-75,
        marginBottom:30,
        borderTopLeftRadius:10,
        borderTopRightRadius:10,
        borderBottomLeftRadius:10,
        borderBottomRightRadius:10
    }
})
