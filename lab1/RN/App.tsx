import { StatusBar } from 'expo-status-bar';
import React, {useState} from 'react';
import { StyleSheet, Text, View, ScrollView, Platform, Image, TextInput} from 'react-native';
import Constants from 'expo-constants';
import Button from './components/Button'

export default function App() {

  const [focused, setFocused] = useState(false)

  return (
    <View style={styles.container}>
      <ScrollView stickyHeaderIndices={[0]} style={styles.header}>
        <View >
          <Text style={styles.headerTitle}>
              Example 1
            </Text>
          </View>
      </ScrollView>

      <View style={styles.contentContainer}>
        <Image source={require('./assets/imglab1.png')} style={styles.img}/>
        <View style={styles.buttonContainer}>
          <View style={styles.buttonGroup}>
            <Button/>
            <Button/>
          </View>
          <View style={styles.buttonGroup}>
            <Button/>
            <Button/>
          </View>
        </View>
        <View style={styles.emailContainer}>
          <Text style={styles.emailTitle}>
            Email
          </Text>
          <TextInput
            onFocus={() => setFocused(true)}
            onBlur={() => setFocused(false)}
            selectionColor={'red'}
            style={[styles.textInput, focused && styles.borderFocused]}
            placeholder="Enter email"
            onChangeText={text => console.log(text)}
          />
        </View>
      </View>
      <StatusBar style="light" backgroundColor="#1a574a" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: Platform.OS === 'ios' ? 0 : Constants.statusBarHeight,
    backgroundColor:'#fafafa'
  },
  header: {
    flex:1,
    backgroundColor:'#2c8576',
    color:'white',
    fontWeight:'bold',
    elevation:3
  },
  headerTitle: {
    fontWeight:"bold",
    color:"white",
    fontSize: 20,
    marginLeft: 14,
    marginTop:10
  },
  emailTitle: {
    padding:4, fontSize:18, color:'#7c7c7c'
  },
  contentContainer: {
    flex: 12,
    alignItems: 'center',
    backgroundColor: '#fafafa',
    paddingTop: 20,
  },
  img: {
    width:140,
    height:140
  },
  buttonContainer: {
    backgroundColor:'#fafafa',
    flexDirection:'row',
    justifyContent:'space-evenly',
    alignContent:'space-around',
    width:'100%'
  },
  buttonGroup:{
    padding:20
  },
  button:{
    padding: 20
  },
  emailContainer:{
    flexDirection:"row",
    alignItems:'stretch',
    justifyContent:'space-evenly',
    alignContent:'space-around',
    width:'100%'
  },
  textInput: {
    fontSize:18, 
    paddingTop:4,
     borderBottomColor: 'lightgrey',
    borderBottomWidth:2, 
    width:200
  },
  borderFocused: {
    borderBottomColor: '#cd1c61'
  }
});
