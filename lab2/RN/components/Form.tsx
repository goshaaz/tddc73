import React, {useState} from 'react';
import { Button, TextInput, View , Text, StyleSheet, TouchableOpacity} from 'react-native';
import {Picker} from '@react-native-picker/picker';
import Card from './Card'

const currentYear = new Date().getFullYear()
const currentMonth = new Date().getMonth() + 1
console.log(currentMonth)

const years: number[] = []
for(let i = 0; i < 10; i++){
    years.push(currentYear+i);
}

const months: number[] = [1,2,3,4,5,6,7,8,9,10,11,12]

export default function MyReactNativeForm(){
    const [cardValue, setCardValue] = useState('')

    const [cardFocus, setCardFocus] = useState(false)
    const [nameFocus, setNameFocus] = useState(false)
    const [monthFocus, setMonthFocus] = useState(false)
    const [yearFocus, setYearFocus] = useState(false)
    const [cvvFocus, setCvvFocus] = useState(false)

    const [selectedMonth, setSelectedMonth] = useState('Month');
    const [selectedYear, setSelectedYear] = useState('Year');

    const handleCardInput = (e:string) => {
        if(e.length < 2){
            setCardValue(e)
            return
        } 
        e = e.replace(/\s/g, '');
        let joy=e.match(/.{1,4}/g)
        setCardValue(joy!.join(' '))
    }

        return (
            <View style={styles.container}> 
            <Card/>
                <Text style={styles.labelText}>
                    Card Number
                </Text>
                <TextInput maxLength={19} keyboardType="numeric" value={cardValue} onFocus={() => setCardFocus(true)} onBlur={() => setCardFocus(false)} style={[styles.inputField, cardFocus && styles.inputFocus]} onChangeText={handleCardInput}/>
                <Text style={styles.labelText}>
                    Card Name
                </Text>
                <TextInput onFocus={() => setNameFocus(true)} onBlur={() => setNameFocus(false)} style={[styles.inputField, nameFocus && styles.inputFocus]} onChangeText={(e) => {console.log(e)}}/>
                <Text style={styles.labelText}>
                    Expiration Date
                </Text>
                <View style={{ flexDirection:'row' ,width:"100%", marginBottom:14}}>
                    <View style={[{flex:1, borderWidth: 0.9,
                        borderBottomLeftRadius: 4,
                        borderBottomRightRadius: 4,
                        borderTopLeftRadius:4,
                        borderTopRightRadius:4,
                        height:40,
                        borderColor:"rgba(0,0,0,0.3)",}, monthFocus && styles.inputFocus]}>
                    <Picker onFocus={() => setMonthFocus(true)} onBlur={() => setMonthFocus(false)}  onValueChange={(month) =>
                            setSelectedMonth(month)
                        } selectedValue={selectedMonth} style={{flex:1, transform:[{translateY:-8}]}} mode="dropdown">
                        <Picker.Item enabled={false} style={{color:"rgba(0,0,0,0.3)"}} label="Month" value="0" />
                        {months.map((month, index) => {
                            return <Picker.Item key={month.toString()} label={month < 10 ? "0" + month.toString() : month.toString()} value={month} enabled={(selectedYear === 'Year' || parseInt(selectedYear) > currentYear || month >= currentMonth) ? true : false} style={{color:(selectedYear === 'Year' || parseInt(selectedYear) > currentYear || month >= currentMonth) ? "rgba(0,0,0,1)" : "rgba(0,0,0,0.3)"}}/>
                        })}
                    </Picker>
                    </View>
                    <View style={{flex:0.05}}>

                    </View>
                    <View style={[{flex:1, borderWidth: 0.9,
                        borderBottomLeftRadius: 4,
                        borderBottomRightRadius: 4,
                        borderTopLeftRadius:4,
                        borderTopRightRadius:4,
                        height:40,
                        borderColor:"rgba(0,0,0,0.3)",},  yearFocus && styles.inputFocus]}>
                    <Picker onFocus={() => setYearFocus(true)} onBlur={() => setYearFocus(false)} onValueChange={(year) => {
                                setSelectedYear(year)
                                if((parseInt(year) === currentYear) && parseInt(selectedMonth) < currentMonth){
                                    setSelectedMonth('Month')
                                }
                            }
                        } selectedValue={selectedYear} style={{flex:1, transform:[{translateY:-8}]}} mode="dropdown">
                        <Picker.Item enabled={false} style={{color:"rgba(0,0,0,0.3)"}} label="Year" value="year" />
                        {years.map((year) => {
                            return <Picker.Item key={year.toString()} label={year.toString()} value={year}/>
                        })}
                    </Picker>
                    </View>
                    <View style={{flex:0.1}}>

                    </View>
                    <View style={[{flex:0.5}, cvvFocus && styles.inputFocus]}>
                        <Text style={[styles.labelText, {position:"absolute", transform:[{translateY:-24}]}]}>
                            CVC
                        </Text>
                    <TextInput onFocus={() => setCvvFocus(true)} onBlur={() => setCvvFocus(false)} maxLength={4} keyboardType="numeric" style={[styles.inputField,cvvFocus && styles.inputFocus]} />
                    </View>
                </View>
                    <TouchableOpacity style={{padding:10, width:"100%", justifyContent:"center", alignItems:"center", backgroundColor:"#0055d3", borderBottomLeftRadius:4, borderBottomRightRadius:4,borderTopLeftRadius:4, borderTopRightRadius:4}} onPress={() => {console.log('')}}>
                        <Text style={{color:"white", fontWeight:"bold", fontSize:16}}>
                            Submit
                        </Text>
                </TouchableOpacity>
            </View>
        )
}

const styles = StyleSheet.create({
    container: {
      backgroundColor: 'white',
      width:"95%",
      padding: 30,
        borderBottomLeftRadius: 6,
        borderBottomRightRadius: 6,
        borderTopLeftRadius:6,
        borderTopRightRadius:6,
        shadowColor: "#000",
        shadowOffset: {
            width: 0,
            height: 2,
        },
        shadowOpacity: 0.25,
        shadowRadius: 3.84,
        elevation: 5,
    },
    inputField: {
        paddingHorizontal:10,
        paddingVertical:5,
        borderWidth: 0.9,
        borderBottomLeftRadius: 4,
        borderBottomRightRadius: 4,
        borderTopLeftRadius:4,
        borderTopRightRadius:4,
        borderColor:"rgba(0,0,0,0.3)",
        color:"#505e77", 
        fontWeight:"bold", marginBottom:10
    },
    inputFocus:{
        borderColor:"#0055d3"
    },
    labelText:{
        color: "#505e77",
        paddingVertical:3,
        fontWeight:"bold",
        fontSize:14
    },
    expirationContainer:{
        flex:1,
        flexDirection:"row", 
        borderWidth: 0.9,
        borderBottomLeftRadius: 4,
        borderBottomRightRadius: 4,
        borderTopLeftRadius:4,
        borderTopRightRadius:4,
        borderColor:"rgba(0,0,0,0.3)",
        color:"#505e77", 
        fontWeight:"bold", marginBottom:10
    },
});