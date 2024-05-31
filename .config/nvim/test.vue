<script setup lang="ts">
import {ref,onBeforeMount} from 'vue';
const value = ref(0);
const props = defineProps<{
  value: number;
}>()
const emit = defineEmits<{
  (e: 'update:value-changed'):void; 
  
}>()
const _value = ref(0);
const add = () => value.value++;
const dec = () => value.value--;
onBeforeMount(() => _value.value = props.value);
</script>

<template>
  {{_value}}
  <button @click="add()">add()</button>
  <button @click="dec()">dec()</button>
</template>
