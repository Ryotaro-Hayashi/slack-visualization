<template>
  <v-container>
    <v-row justify="center">

      <!-- ランキング表示カラム -->
      <v-col cols="12" sm="8" md="4" align="start">
        <v-card>
          <!-- カードテキスト -->
          <v-card-text>
            <v-row align="center" justify="center">
              <v-col cols="12" sm="8" md="8">
                チャンネルを選択
              </v-col>

              <v-col cols="12" sm="4" md="4" align="center">
                <v-dialog
                  v-model="dialog"
                  scrollable
                  max-width="300px"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      color="primary"
                      dark
                      v-bind="attrs"
                      v-on="on"
                    >
                      追加
                    </v-btn>
                  </template>

                  <v-card>
                    <v-card-title class="justify-center">チャンネルを選択</v-card-title>
                    <v-divider></v-divider>
                    <v-card-text style="height: 300px;">
                      <v-container>
                        <v-checkbox
                            v-for="chip in chips"
                            :key="chip.name"
                            v-model="chip.active"
                            :label="`# ${chip.name.toString()}`"
                        ></v-checkbox>
                      </v-container>
                    </v-card-text>
                    <v-divider></v-divider>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn
                        color="blue darken-1"
                        text
                        @click="dialog = false"
                      >
                        閉じる
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-col>
            </v-row>
        
            <v-spacer></v-spacer>

            <v-chip
              v-for="chip in showActiveChannels"
              :key="chip.name"
              class="ma-2"
              close
              label
              @click:close="chip.active = false"
            >
              {{chip.name}}
            </v-chip>
            
            </v-card-text>

            <v-divider></v-divider>

            <v-card-text>
              <p>期間を選択</p>
              
              <v-menu
                ref="menu"
                v-model="menu"
                :close-on-content-click="false"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    v-model="dateRangeText"
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                    class="date_text_field"
                  />
                </template>

                <v-date-picker
                  ref="picker"
                  v-model="dates"
                  range
                  @change="save"
                ></v-date-picker>
              </v-menu>
              
            </v-card-text>

            <v-divider></v-divider>

            <v-card-text>
              <p>ランキング</p>
              <!-- ランキング表示 -->
            <v-list subheader two-line>

              <v-container>
                <v-list-item v-for="trend in trends" :key="trend.title">
                  <v-list-item-avatar rounded  :color="trend.color">
                    <v-icon dark large>
                      {{ trend.icon }}
                    </v-icon>
                  </v-list-item-avatar>

                  <v-list-item-content>
                    <v-list-item-title v-text="trend.title"></v-list-item-title>

                    <v-list-item-subtitle v-text="trend.subtitle"></v-list-item-subtitle>
                  </v-list-item-content>
                  
                </v-list-item>
              
              </v-container>

            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- グラフ表示 -->
      <v-col cols="12" sm="8" md="8" align="start">
        <!-- カード領域 -->
        <v-card>
          
          <v-card-text>
            <v-container>
              <v-row>
              <v-col cols="6" sm="6" md="6">
                各単語の流行グラフ
              </v-col>
              <v-col cols="6" sm="6" md="6" align="end">
                過去1ヶ月
              </v-col>
              </v-row>
            </v-container>

            <v-list subheader two-line>
              <v-list-item v-for="trend in trends" :key="trend.title">
                <v-container>
                  <v-row>
                    <v-list-item-avatar rounded  :color="trend.color" size="20">
                      <v-icon dark>
                        {{ trend.icon }}
                      </v-icon>
                    </v-list-item-avatar>

                    <v-list-item-content v-text="trend.title">
                    </v-list-item-content>
                  </v-row>

                  <v-row>
                    <v-col>
                      <v-list-item-content>
                        <!-- 流行グラフ -->
                        <v-sparkline
                          :labels="labels"
                          :value="trend.value"
                          line-width="1"
                          padding="10"
                          :smooth="10"
                          fill
                          width="500"
                          :gradient="gradient"
                        ></v-sparkline>
                      </v-list-item-content>
                    </v-col>
                  </v-row>
                </v-container>
              </v-list-item>

              <v-divider></v-divider>

            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

    </v-row>  
  </v-container>
</template>

<script>
import Logo from '~/components/Logo.vue'
import VuetifyLogo from '~/components/VuetifyLogo.vue'

// const gradients =
  // ['#222'],
  // ['#42b3f4'],
  // ['red', 'orange', 'yellow'],
  // ['purple', 'violet'],
  // ['#00c6ff', '#F0F', '#FF0'],
  // ['#f72047', '#ffd200', '#1feaea']

export default {
  components: {
    Logo,
    VuetifyLogo,
  },
  data: () => ({
    gradient: [
      '#f72047', '#ffd200', '#1feaea'
    ],
    dialog: false,
    chips: [
      {
        active: true,
        name: 'general'
      },
      {
        active: false,
        name: 'random'
      },
      {
        active: true,
        name: 'agenda'
      },
      {
        active: false,
        name: 'times_hayashi'
      },
      {
        active: false,
        name: 'times_test'
      },
    ],
    trends: [
      {
        icon: 'mdi-numeric-1',
        subtitle: '23件のメッセージ',
        title: 'スライドレビュー',
        color: 'gold',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-2',
        subtitle: '19件のメッセージ',
        title: '発表',
        color: 'silver',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-3',
        subtitle: '18件のメッセージ',
        title: 'ポスター',
        color: 'bronze',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-4',
        subtitle: '23件のメッセージ',
        title: 'スライドレビュー',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-5',
        subtitle: '19件のメッセージ',
        title: '発表',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-6',
        subtitle: '18件のメッセージ',
        title: 'ポスター',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-7',
        subtitle: '23件のメッセージ',
        title: 'スライドレビュー',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-8',
        subtitle: '19件のメッセージ',
        title: '発表',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-9',
        subtitle: '18件のメッセージ',
        title: 'ポスター',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-10',
        subtitle: '23件のメッセージ',
        title: 'スライドレビュー',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          310,
          460,
          250,
          800,
        ],
      },
    ],
    dates: ['2021-01-25', '2021-01-26'],
    labels: [
      '8/20',
      '8/24',
      '8/28',
      '9/2',
      '9/6',
      '9/10',
      '9/15',
      '9/20',
    ],
  }),
  computed: {
    // 日付のフォーマット調整
    dateRangeText () {
      // 日付を"~"で結合してから文字列化
      let date_range = String(this.dates.join(' ~ '));
      // "-"で分割
      let date_range_splitted = date_range.split('-');

      console.log(date_range_splitted)

      let zero = '0';

      for (let i = 0; i < date_range_splitted.length; i++) {
        // 頭文字が0のとき
        if (date_range_splitted[i].indexOf(zero) === true) {
          // 頭文字の0を削除して再度配列に格納
          date_range_splitted[i] = date_range_splitted[i].slice(1);
        }
      }
      // "/"で結合
      date_range = date_range_splitted.join('/');

      console.log(date_range)
    
      return date_range
    },
    showActiveChannels() {
      return this.chips.filter(chip => chip.active)
    },
  },
}
</script>

<style type="text/css">

/* pタグの改行をなくす */
p {
  display:inline;
}

.date_text_field {
  margin: 0rem 4rem 0rem 1.5rem;
}

.gold {
  background: linear-gradient(#E0CA82, #CAA846);
}

.silver {
  background: linear-gradient(#DCDDDD, #9EACB4);
}

.bronze {
  background: linear-gradient(#C9AE5D, #C47022);
}

</style>