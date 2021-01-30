<template>
  <v-container>
    <v-row justify="center">

      <!-- ランキング表示カラム -->
      <v-col cols="12" md="5" lg="5" xl="5" align="start">
        <v-card>
          <!-- カードテキスト -->
          <v-card-text>
            <v-container>
              <v-row align="center" justify="center">
                <v-col cols="7">
                  チャンネルを選択
                </v-col>

                <v-col cols="5" align="center">
                  <v-dialog
                    v-model="dialog"
                    scrollable
                    max-width="300px"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        light
                        v-bind="attrs"
                        v-on="on"
                        small
                        class="grey--text text--darken-1"
                        outlined
                      >
                        <v-icon left color="grey">
                          mdi-plus-box
                        </v-icon>
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
            </v-container>
        
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
      <v-col cols="12" md="7" lg="7" xl="7" align="start">
        <!-- カード領域 -->
        <v-card>
          
          <v-card-text>
            <v-container>
              <v-row>
              <v-col>
                各単語の流行グラフ
              </v-col>
              <!-- <v-col cols="12" sm="4" md="4" lg="4" xl="8" align="end">
                過去1ヶ月
              </v-col> -->
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
        subtitle: '54件のメッセージ',
        title: 'スライドレビュー',
        color: 'gold',
        value: [
          200,
          475,
          410,
          390,
          310,
          460,
          650,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-2',
        subtitle: '52件のメッセージ',
        title: '発表',
        color: 'silver',
        value: [
          200,
          275,
          410,
          390,
          610,
          460,
          450,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-3',
        subtitle: '51件のメッセージ',
        title: 'ポスター',
        color: 'bronze',
        value: [
          200,
          375,
          410,
          390,
          310,
          460,
          750,
          800,
        ],
      },
      {
        icon: 'mdi-numeric-4',
        subtitle: '46件のメッセージ',
        title: 'デモ',
        color: 'grey',
        value: [
          300,
          275,
          410,
          390,
          510,
          460,
          450,
          600,
        ],
      },
      {
        icon: 'mdi-numeric-5',
        subtitle: '45件のメッセージ',
        title: '実機',
        color: 'grey',
        value: [
          200,
          275,
          310,
          390,
          410,
          360,
          350,
          500,
        ],
      },
      {
        icon: 'mdi-numeric-6',
        subtitle: '33件のメッセージ',
        title: 'ポスター作成',
        color: 'grey',
        value: [
          200,
          675,
          410,
          460,
          800,
          610,
          250,
          490,
        ],
      },
      {
        icon: 'mdi-numeric-7',
        subtitle: '32件のメッセージ',
        title: 'スライド作成',
        color: 'grey',
        value: [
          200,
          675,
          410,
          460,
          800,
          610,
          250,
          390,
        ],
      },
      {
        icon: 'mdi-numeric-8',
        subtitle: '31件のメッセージ',
        title: '報告書',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          210,
          60,
          150,
          100,
        ],
      },
      {
        icon: 'mdi-numeric-9',
        subtitle: '24件のメッセージ',
        title: '提出物',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          210,
          60,
          150,
          80,
        ],
      },
      {
        icon: 'mdi-numeric-10',
        subtitle: '19件のメッセージ',
        title: '実装',
        color: 'grey',
        value: [
          200,
          675,
          410,
          390,
          210,
          60,
          150,
          50,
        ],
      },
    ],
    dates: ['2021-01-25', '2021-01-26'],
    labels: [
      '12/20',
      '12/24',
      '12/28',
      '1/2',
      '1/6',
      '1/10',
      '1/15',
      '1/26',
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
  margin: 0rem 0.5rem 0rem 0.5rem;
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