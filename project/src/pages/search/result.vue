<template>
  <v-container fluid style="height: 90vh;" fill-height>
    <v-row align="center" justify="start">
      <v-col cols="5">
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

      <v-col cols="12">
        <v-card>
          <v-card-text>関連する単語：スライド作成，スライドレビュー，デモ，発表</v-card-text>
        </v-card>
        
      </v-col>

      <v-col cols="12">
        <v-card>
          <v-list three-line>
            <template v-for="(item, index) in items">
              
              <v-subheader
                v-if="item.header"
                :key="item.header"
                v-text="item.header"
              ></v-subheader>

              <v-divider
                v-else-if="item.divider"
                :key="index"
                :inset="item.inset"
              ></v-divider>

              <v-list-item
                v-else
                :key="item.title"
              >
                <v-list-item-avatar>
                  <v-img :src="item.avatar"></v-img>
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-list-item-title v-html="item.title"></v-list-item-title>

                  <v-list-item-subtitle v-html="item.subtitle"></v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </template>
          </v-list>
        </v-card>
      </v-col>

      <v-col cols="12" class="d-flex justify-end">
        <v-pagination
          v-model="page"
          :length="2"
        ></v-pagination>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    data: () => ({
      page: 1,
      query: '',
      items: [
        { header: '検索結果83件' },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
          title: 'Brunch this weekend? <span class="grey--text text--lighten-1">14:20</span>',
          subtitle: `<span class="text--primary">Ali Connors</span> &mdash; I'll be in your neighborhood doing errands this weekend. Do you want to hang out?`,
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
          title: 'Summer BBQ <span class="grey--text text--lighten-1">14:20</span>',
          subtitle: `<span class="text--primary">to Alex, Scott, Jennifer</span> &mdash; Wish I could come, but I'm out of town this weekend.`,
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
          title: 'Oui oui <span class="grey--text text--lighten-1">14:20</span>',
          subtitle: '<span class="text--primary">Sandra Adams</span> &mdash; Do you have Paris recommendations? Have you ever been?',
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg',
          title: 'Birthday gift <span class="grey--text text--lighten-1">14:20</span>',
          subtitle: '<span class="text--primary">Trevor Hansen</span> &mdash; Have any ideas about what we should get Heidi for her birthday?',
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/5.jpg',
          title: 'Recipe to try',
          subtitle: '<span class="text--primary">Britta Holt</span> &mdash; We should eat this: Grate, Squash, Corn, and tomatillo Tacos.',
        },
      ],
    }),
    methods:{
      submit () {
    }
    },
  }
</script>