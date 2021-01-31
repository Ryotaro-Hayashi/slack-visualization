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
          <v-card-text>関連する単語：レビュー，デモ，発表</v-card-text>
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
        { header: '検索結果54件' },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg',
          title: 'Ryotaro <span class="grey--text text--lighten-1">20:20</span>',
          subtitle: '頂いたレビューをもとに発表スライドを修正しました. 確認よろしくお願いします.',
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/2.jpg',
          title: 'Ryotaro Hyashi <span class="grey--text text--lighten-1">16:27</span>',
          subtitle: `スライドのレビューするから各位準備しておいてね`,
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/3.jpg',
          title: '林  遼太朗 <span class="grey--text text--lighten-1">16:20</span>',
          subtitle: '<span class="text--primary">@here</span> 7/13(金)4限にデモのテストします！お手数ですがよろしくお願いします！🙇‍♂️',
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/1.jpg',
          title: '林  遼太朗 <span class="grey--text text--lighten-1">11:20</span>',
          subtitle: `<span class="text--primary">@here </span>発表で使うスライドの修正っていつ終わる？`,
        },
        { divider: true, inset: true },
        {
          avatar: 'https://cdn.vuetifyjs.com/images/lists/5.jpg',
          title: 'Hayashi <span class="grey--text text--lighten-1">11:08</span>',
          subtitle: '発表時間は10分です！レビューお願いします！',
        },
      ],
    }),
    methods:{
      submit () {
    }
    },
  }
</script>