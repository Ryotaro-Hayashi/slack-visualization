<template>
  <v-container fluid style="height: 70vh;" fill-height>
    <v-row class="flex-column" align="center" justify="center">
      <v-col cols="12" align="center">
        <v-img
          :src="require('@/static/logo.png')"
          width="20%"
          height="20%"
        ></v-img>
      </v-col>
      <v-col cols="10" md="7" lg="7" xl="7">
        <!-- <v-form ref="form" @submit="move" action='search/result'> -->
        <v-form ref="form" action='search/result'>
          <v-text-field
            v-model="query"
            prepend-inner-icon="mdi-magnify"
            label="単語を検索"
            solo
            background-color="white"
          ></v-text-field>
        </v-form>
      </v-col>
    </v-row>

  </v-container>
</template>

<script>
  export default {
    data: () => ({
      query: '',
    }),
    methods:{
    },
  }
</script>