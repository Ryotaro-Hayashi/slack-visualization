<template>
  <v-app light>
    <!-- サイドバー -->
    <v-navigation-drawer
      app
      v-model="drawer"
      :mini-variant="miniVariant"
      color="side-bar-color"
      fixed
    >
      <!-- リストで選択肢を列挙 -->
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon color="side-bar-icon-color">{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title class="grey--text text--lighten-5" v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-spacer />

    </v-navigation-drawer>

    <!-- ナビゲーションバー -->
    <v-app-bar app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-btn icon @click.stop="miniVariant = !miniVariant">
        <v-icon>mdi-{{ `chevron-${miniVariant ? 'right' : 'left'}` }}</v-icon>
      </v-btn>
      <button onclick="location.href='/slack-visualization'" >
        <v-avatar :tile="true">
        <v-img :src="require('@/static/icon.png')" width="75%" height="75%" ></v-img>
      </v-avatar>
      </button>
      <v-spacer />
    </v-app-bar>

    <!-- SPAの部分 -->
    <v-main>
      <v-container>
        <nuxt />
      </v-container>
    </v-main>

    <!-- フッター -->
    <v-footer :absolute="true" app class="justify-center pl-0" inset>
      <span>&copy; {{ new Date().getFullYear() }} Ryotaro Hayashi All Rights Reserved</span>
    </v-footer>
    
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      drawer: true,
      items: [
        {
          icon: 'mdi-apps',
          title: 'Welcome',
          to: '/welcome',
        },
        {
          icon: 'mdi-trending-up',
          title: 'Trend Topics',
          to: '/',
        },
        {
          icon: 'mdi-text-search',
          title: 'Search Messages',
          to: '/messages',
        },
        {
          icon: 'mdi-cog-outline',
          title: 'Settings',
          to: '/settings',
        },
      ],
      miniVariant: false,
      right: true,
    }
  },
}
</script>

<style type="text/css">

/* ロゴ押下時のボタンの枠線を消す */
button:focus {
	outline:0;
}

</style>