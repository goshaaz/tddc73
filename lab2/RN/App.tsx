import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Form from './components/Form'

export default function App() {
  return (
    <View style={styles.container}>
      <Form/>
      <Text>
        Test
      </Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#d4eafd',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
