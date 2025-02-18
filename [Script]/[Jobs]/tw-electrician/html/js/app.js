let audioPlayer = null;
const store = Vuex.createStore({
    components: {},

    state: {
        notifications: []
    },
    getters: {},
    mutations: {},
    actions: {},
    searchInput: ""
});

const app = Vue.createApp({
    components: {},
    data: () => ({
        mainShow: false,
        finishShow: false,
        requestMenuShow: false,
        switchShow: false,
        voltShow: false,
        foundBrokenPano: false,
        lineMeterShow: false,
        notifyShow: false,
        playerShow: false,
        scoreBoxShow: false,
        wiringShow: false,
        foringShow: false,
        liftInfoShow: false,
        panos: [...Array(12).keys()].map(i => ({ id: `pano${i + 1}` })),
        activeSwitch: null,
        removedScrews: {},
        voltVolumeModal: 0,
        intervalId: null,
        progressbar: 0,
        progressbarLabel: "",
        moneyType: "$",
        scriptName: "TWORST",
        finishjobData: false,
        notifications: [],
        Locales: {},
        invitePlayer: {
            1: false,
            2: false,
            3: false,
            4: false
        },
        jobStart: false,
        progressData: [],
        inviteModal: "",
        playerData: {
            playerName: "Samet Kırıcı",
            playerMoney: 56000,
            playerIdentifier: "KUR10469",
            playerLevel: 1,
            playerXp: 100,
            playerNextXp: 200,
            source: 1,
            playerImage: "https://media.discordapp.net/attachments/746645694194122775/1135514215164162048/WhatsApp_Gorsel_2023-07-31_saat_12.54.20.jpg?ex=668db4c5&is=668c6345&hm=6ecd264a27f98e319561b6d7fd187ce3601153a9ad4085c290b93174082f3569&format=webp&width=671&height=671&"
        },
        playerListData: [
            {
                playerLevel: 1,
                playerOwner: true,
                playerName: "Samet Kırıcı",
                playerIdentifier: "KUR10469",
                source: 1,
                playerImage: "https://media.discordapp.net/attachments/746645694194122775/1135514215164162048/WhatsApp_Gorsel_2023-07-31_saat_12.54.20.jpg?ex=668db4c5&is=668c6345&hm=6ecd264a27f98e319561b6d7fd187ce3601153a9ad4085c290b93174082f3569&format=webp&width=671&height=671&"
            },
            {
                playerLevel: 1,
                playerOwner: false,
                playerName: "Samet Kırıc,",
                playerIdentifier: "KUR10468",
                source: 2,
                playerImage: "https://media.discordapp.net/attachments/746645694194122775/1135514215164162048/WhatsApp_Gorsel_2023-07-31_saat_12.54.20.jpg?ex=668db4c5&is=668c6345&hm=6ecd264a27f98e319561b6d7fd187ce3601153a9ad4085c290b93174082f3569&format=webp&width=671&height=671&"
            }
        ],
        selectRegionData: false,
        regionData: [
            {
                regionKey: 1,
                regionInfo: {
                    regionTitle: "Los Santos",
                    regionDetails: "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                    regionJobTask: "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                    regionImage: "region.png"
                },
                regionMaxPlayer: 1,
                regionMinimumLevel: 0,
                regionAwards: {
                    money: 1000,
                    xp: 100,
                    onlineJobExtraAwards: 2
                },
                regionJobTask: [
                    {
                        jobName: "fixWiring",
                        jobCount: 4,
                        jobLabel: " Adet Kabloları Tamir Et"
                    },
                    {
                        jobName: "fixSoket",
                        jobCount: 4,
                        jobLabel: " Adet Soket Değiştir"
                    }
                ],
                regionItems: [
                    {
                        itemName: "Kablo",
                        itemCount: 4,
                        itemLabel: "Kablo Tamir Et",
                        itemImage: "item.png"
                    },
                    {
                        itemName: "Soket",
                        itemCount: 4,
                        itemLabel: "Soket1 Değiştir",
                        itemImage: "item.png"
                    },
                    {
                        itemName: "Soket",
                        itemCount: 4,
                        itemLabel: "Soket2 Değiştir",
                        itemImage: "item.png"
                    },
                    {
                        itemName: "Soket",
                        itemCount: 4,
                        itemLabel: "Soket3 Değiştir",
                        itemImage: "item.png"
                    }
                ]
            },
            {
                regionKey: 2,
                regionInfo: {
                    regionTitle: "Los Santos",
                    regionDetails: "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                    regionJobTask: "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                    regionImage: "region.png"
                },
                regionMaxPlayer: 2,
                regionMinimumLevel: 1,
                regionAwards: {
                    money: 1000,
                    xp: 100,
                    onlineJobExtraAwards: 2
                },
                regionJobTask: [
                    {
                        jobName: "fixWiring",
                        jobCount: 4,
                        jobLabel: " Adet Kabloları Tamir Et"
                    },
                    {
                        jobName: "fixSoket",
                        jobCount: 4,
                        jobLabel: " Adet Soket Değiştir"
                    }
                ]
            },
            {
                regionKey: 3,
                regionInfo: {
                    regionTitle: "Los Santos",
                    regionDetails: "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                    regionJobTask: "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                    regionImage: "region.png"
                },
                regionMaxPlayer: 3,
                regionMinimumLevel: 2,
                regionAwards: {
                    money: 1000,
                    xp: 100,
                    onlineJobExtraAwards: 2
                },
                regionJobTask: [
                    {
                        jobName: "fixWiring",
                        jobCount: 4,
                        jobLabel: " Adet Kabloları Tamir Et"
                    },
                    {
                        jobName: "fixSoket",
                        jobCount: 4,
                        jobLabel: " Adet Soket Değiştir"
                    }
                ]
            },
            {
                regionKey: 4,
                regionInfo: {
                    regionTitle: "Los Santos",
                    regionDetails: "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                    regionJobTask: "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                    regionImage: "region.png"
                },
                regionMinimumLevel: 3,
                regionMaxPlayer: 4,
                regionAwards: {
                    money: 1000,
                    xp: 100,
                    onlineJobExtraAwards: 2
                },
                regionJobTask: [
                    {
                        jobName: "fixWiring",
                        jobCount: 4,
                        jobLabel: " Adet Kabloları Tamir Et"
                    },
                    {
                        jobName: "fixSoket",
                        jobCount: 4,
                        jobLabel: " Adet Soket Değiştir"
                    }
                ]
            },
            {
                regionKey: 5,
                regionInfo: {
                    regionTitle: "Los Santos",
                    regionDetails: "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                    regionJobTask: "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                    regionImage: "region.png"
                },
                regionMinimumLevel: 4,
                regionAwards: {
                    money: 1000,
                    xp: 100,
                    onlineJobExtraAwards: 2
                },
                regionJobTask: [
                    {
                        jobName: "fixWiring",
                        jobCount: 4,
                        jobLabel: " Adet Kabloları Tamir Et"
                    },
                    {
                        jobName: "fixSoket",
                        jobCount: 4,
                        jobLabel: " Adet Soket Değiştir"
                    }
                ]
            }
        ],
        requstData: {
            hostName: "Samet Kırıcı",
            hostIdentifier: "KUR10469"
        },
        isMouseDown: true
    }),

    watch: {
        lineMeterShow(newVal) {
            if (newVal) {
                this.initializeLineMeter();
            }
        }
    },

    beforeDestroy() {
        document.removeEventListener("mousemove", this.updateLineMeterPosition);
        clearInterval(this.checkInterval);
    },
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);

        if (this.lineMeterShow) {
            this.initializeLineMeter();
        }

        setInterval(() => {
            if (this.foundBrokenPano) {
                if (this.voltShow || this.lineMeterShow) {
                    this.voltShow = false;
                    this.lineMeterShow = false;
                }
            }
        }, 800);

        setInterval(() => {
            if (!this.isMouseDown && this.voltVolumeModal > 0) {
                this.voltVolumeModal = 0;
            }
        }, 22000);

        this.checkInterval = setInterval(() => {
            if (this.notifications.length > 0) {
                this.notifyShow = true;

                let delays = [];
                this.notifications.forEach((notification, index) => {
                    let delay = setTimeout(() => {
                        const indexToRemove = this.notifications.indexOf(notification);
                        if (indexToRemove !== -1) {
                            this.notifications.splice(indexToRemove, 1);
                            if (this.notifications.length === 0) {
                                this.notifyShow = false;
                            }
                        }
                        clearTimeout(delays[indexToRemove]);
                    }, 1500 * (index + 1));
                });
            }
        }, 2500);
    },

    methods: {
        handleMouseDown(e, panoId) {
            if (panoId === this.randomPanoId) {
                this.voltVolumeModal = Math.floor(Math.random() * 4);
                +1;

                this.isMouseDown = true;
                if (this.lineMeterShow) {
                    this.updateLineMeterPosition(e);
                }
                if (!this.foundBrokenPano) {
                    setTimeout(() => {
                        this.foundBrokenPano = true;
                    }, 2000);
                }
            } else {
                this.voltVolumeModal = Math.floor(Math.random() * 6) + 270;
                if (this.lineMeterShow) {
                    this.updateLineMeterPosition(e);
                }
            }
        },
        handleMouseUp(panoId) {
            setTimeout(() => {
                if (!this.isMouseDown && this.voltVolumeModal > 0) {
                    // this.isMouseDown = false;
                    // this.voltVolumeModal = 0;
                }
            }, 1000);
        },
        initializeLineMeter() {
            this.$nextTick(() => {
                const lineMeter = document.getElementById("lineMeter");
                if (lineMeter) {
                    this.isMouseDown = false;

                    const onMouseMove = e => {
                        if (this.isMouseDown) {
                            this.updateLineMeterPosition(e);
                        }
                    };

                    const onMouseDown = () => {
                        this.isMouseDown = true;

                        document.body.style.cursor = "none";
                    };

                    const onMouseUp = () => {
                        this.isMouseDown = false;
                        document.body.style.cursor = "default";
                    };

                    document.addEventListener("mousemove", onMouseMove);
                    document.addEventListener("mousedown", onMouseDown);
                    document.addEventListener("mouseup", onMouseUp);
                }
            });
        },
        updateLineMeterPosition(e) {
            const lineMeter = document.getElementById("lineMeter");
            if (lineMeter) {
                lineMeter.style.left = `${e.clientX}px`;
                lineMeter.style.top = `${e.clientY}px`;
            }
        },
        handlePanoClick(panoId) {
            if (panoId === this.randomPanoId) {
                setTimeout(() => {
                    this.foundBrokenPano = true;
                }, 2000);
            }
        },
        handleScrewClick(panoId, screwId) {
            if (!this.foundBrokenPano) {
                if (panoId === this.randomPanoId) {
                    setTimeout(() => {
                        setTimeout(() => {
                            this.foundBrokenPano = true;
                        }, 2000);
                    }, 1000);
                }
            } else {
                // if (panoId === this.randomPanoId) {
                this.activeSwitch = panoId;
                this.removeScrew(panoId, screwId);
                // }
            }
        },
        handleSwitchCoverClick(panoId) {
            if (!this.foundBrokenPano && panoId === this.randomPanoId) {
            } else {
                if (panoId === this.randomPanoId && this.checkScrews(panoId)) {
                    this.replaceSwitch(panoId);
                } else if (this.checkScrews(panoId)) {
                    this.replaceSwitch(panoId);
                }
            }
        },
        removeScrew(panoId, screwId) {
            if (!this.removedScrews[panoId]) {
                this.removedScrews[panoId] = [];
            }
            this.removedScrews[panoId].push(screwId);

            this.$nextTick(() => {
                const screw = document.getElementById(panoId).querySelector(`.screw${screwId}`);
                if (screw) {
                    screw.classList.add("removing");
                    screw.addEventListener("animationend", () => {
                        screw.remove();
                        if (this.checkScrews(panoId)) {
                            this.showSwitchCover(panoId);
                        }
                    });
                }
            });
        },
        checkScrews(panoId) {
            return this.removedScrews[panoId] && this.removedScrews[panoId].length === 4;
        },
        showSwitchCover(panoId) {
            this.$nextTick(() => {
                const switchCover = document.getElementById(panoId).querySelector(".panoo");
                if (switchCover) {
                    switchCover.classList.add("show");
                }
            });
        },
        replaceSwitch(panoId) {
            this.$nextTick(() => {
                const switchCover = document.getElementById(panoId).querySelector(".panoo");
                if (switchCover) {
                    switchCover.classList.remove("show");
                }

                document.getElementById(panoId).style.opacity = 0;
                if (panoId !== this.randomPanoId) {
                    this.removedScrews[panoId] = [];
                    document.getElementById(panoId).style.opacity = 100;
                    this.switchShow = false;
                    this.voltShow = false;
                    this.lineMeterShow = false;
                    let regiontrafficKey = this.selectedkey;

                    if (regiontrafficKey && regiontrafficKey.fixed == false) {
                        regiontrafficKey.error = true;
                        setTimeout(() => {
                            postNUI("closeNUIHouse", { regiontrafficKey });
                        }, 1000);
                    } else {
                        setTimeout(() => {
                            regiontrafficKey.error = true;
                            postNUI("closeNUIFixed", { regiontrafficKey });
                        }, 1000);
                    }
                    postNUI("closeNUI");
                    const switchCover = document.getElementById(panoId).querySelector(".panoo");
                    if (switchCover) {
                        switchCover.classList.add("show");
                    }
                    this.$nextTick(() => {
                        for (let i = 1; i <= 4; i++) {
                            const newScrew = document.createElement("div");
                            newScrew.classList.add("screwBox", `screw${i}`);
                            newScrew.style.transform = "scale(1.5)";
                            newScrew.style.opacity = "0";

                            setTimeout(() => {
                                newScrew.style.opacity = "1";
                                newScrew.classList.add("appearing");
                                newScrew.addEventListener("click", event => {
                                    event.stopPropagation();
                                    this.insertScrew(newScrew, panoId);

                                    newScrew.classList.add("inserting");
                                    newScrew.addEventListener("animationend", () => {
                                        newScrew.classList.remove("inserting");
                                        newScrew.style.transform = "scale(1)";
                                    });
                                });

                                const panoBox = document.getElementById(panoId);
                                panoBox.appendChild(newScrew);
                            }, (i + 1) * 300);
                        }
                    });
                    return;
                }
                setTimeout(() => {
                    this.removedScrews[panoId] = [];
                    this.activeSwitch = null;
                    document.getElementById(panoId).style.opacity = 100;
                    this.$nextTick(() => {
                        for (let i = 1; i <= 4; i++) {
                            const newScrew = document.createElement("div");
                            newScrew.classList.add("screwBox", `screw${i}`);
                            newScrew.style.transform = "scale(1.5)";
                            newScrew.style.opacity = "0";

                            setTimeout(() => {
                                newScrew.style.opacity = "1";
                                newScrew.classList.add("appearing");
                                newScrew.addEventListener("click", event => {
                                    event.stopPropagation();
                                    this.insertScrew(newScrew, panoId);

                                    newScrew.classList.add("inserting");
                                    newScrew.addEventListener("animationend", () => {
                                        newScrew.classList.remove("inserting");
                                        newScrew.style.transform = "scale(1)";
                                    });
                                });

                                const panoBox = document.getElementById(panoId);
                                panoBox.appendChild(newScrew);
                            }, (i + 1) * 300);
                        }
                    });
                }, 1000);
            });
        },

        insertScrew(screw, panoId) {
            screw.classList.add("inserting");
            screw.addEventListener("animationend", () => {
                screw.classList.remove("inserting");
                screw.style.transform = "scale(1)";
                this.checkAllScrewsInserted(panoId);
            });
        },
        checkAllScrewsInserted(panoId) {
            const remainingScrews = document.getElementById(panoId).querySelectorAll(".screwBox.inserting");
            if (remainingScrews.length === 0) {
                this.activeSwitch = null;
                let regiontrafficKey = this.selectedkey;
                this.resetScrews(panoId);
                if (regiontrafficKey && regiontrafficKey.fixed == false) {
                    setTimeout(() => {
                        postNUI("switchFixedHouse", { regiontrafficKey });
                    }, 1000);
                } else {
                    setTimeout(() => {
                        postNUI("switchFixed", { regiontrafficKey });
                    }, 1000);
                }
            }
        },
        resetScrews(panoId) {
            const screws = document.getElementById(panoId).querySelectorAll(".screwBox");

            screws.forEach((screw, index) => {
                const newScrew = screw.cloneNode(true);

                newScrew.addEventListener("click", event => {
                    event.stopPropagation();
                    this.handleScrewClick(panoId, index + 1);
                });

                screw.replaceWith(newScrew);
            });
        },
        formatNumber(number) {
            if (number == null) return 0;
            return number.toLocaleString("tr-TR");
        },
        InvitePlayer(key) {
            if (this.inviteModal.length == 0) return;
            if (this.inviteModal < 1) return;
            clicksound("click.wav");
            this.invitePlayer[key] = !this.invitePlayer[key];
            postNUI("invitePlayer", { targetID: this.inviteModal, key: key });

            this.inviteModal = "";
        },
        openInvitePlayer(indentifier, key) {
            const index = this.playerListData.findIndex(x => x.playerIdentifier == indentifier);
            if (index == -1) return;
            if (this.playerListData[index].playerOwner) {
                this.invitePlayer[key] = !this.invitePlayer[key];
            }
            for (let i = 1; i <= 4; i++) {
                if (i != key) {
                    this.invitePlayer[i] = false;
                }
            }
        },
        firePlayer(identifier, key) {
            if (identifier == null) return;
            if (identifier == this.playerData.playerIdentifier) return;

            const index = this.playerListData.findIndex(x => x.playerIdentifier == identifier);
            const owner = this.playerListData.findIndex(x => x.playerOwner);
            if (this.playerListData[index].playerIdentifier === this.playerListData[owner].playerIdentifier) {
                // console.log("Kendi karakterinizi kovamazsınız.");
                clicksound("errorclick.mp3");
                return;
            }
            if (index == -1) return;
            if (this.playerListData[owner].playerOwner) {
                clicksound("click.wav");
                postNUI("firePlayer", { lobbyID: this.playerListData[owner].playerIdentifier, identifier: identifier, targetID: this.playerListData[index].source });
            }
        },
        declineInvite() {
            this.requestMenuShow = false;
            clicksound("errorclick.mp3");
            this.closeNUI();
        },
        acceptInvite() {
            this.requestMenuShow = false;
            clicksound("click.wav");
            postNUI("acceptInvite", { hostIdentifier: this.requstData["hostIdentifier"] });
        },
        selectMission(regionData, regionKey) {
            if (regionData == null) return;
            if (regionKey == null) return;

            if (this.playerData.playerIdentifier == null) return;
            const identifierData = this.playerListData.findIndex(x => x.playerIdentifier == this.playerData.playerIdentifier);
            const playerOwner = this.playerListData.findIndex(x => x.playerOwner == true);
            if (this.playerListData[identifierData].playerIdentifier === this.playerListData[playerOwner].playerIdentifier) {
                if (this.selectRegionData != false && this.selectRegionData != null) {
                    if (regionKey == this.selectRegionData.regionKey) {
                        clicksound("click.wav");
                        postNUI("selectMission", false);
                        return;
                    }
                }

                const regionIndex = this.regionData.findIndex(x => x.regionKey == regionData.regionKey);
                if (regionIndex == -1) return;
                if (this.regionData[regionIndex].regionMinimumLevel > this.playerData.playerLevel) {
                    // console.log("Seviyeniz bu bölgeye giriş yapmak için yetersiz.");
                    clicksound("errorclick.mp3");
                    return;
                }
                clicksound("click.wav");
                postNUI("selectMission", this.regionData[regionIndex]);
            }
        },
        startJob() {
            if (this.selectRegionData == false) {
                clicksound("errorclick.mp3");
                return;
            }
            if (this.selectRegionData == null) {
                clicksound("errorclick.mp3");
                return;
            }
            if (this.jobStart) {
                clicksound("click.wav");
                postNUI("resetJob");
            } else {
                if (this.selectRegionData) {
                    clicksound("click.wav");
                    postNUI("startJob", this.selectRegionData);
                }
            }
        },
        startProgress(label, time) {
            this.progressbarLabel = label;
            this.progressbar = 0;
            clearInterval(this.interval);

            const updateInterval = 100;
            const iterations = (time * 1000) / updateInterval;

            let iterationCount = 0;
            this.interval = setInterval(() => {
                iterationCount++;
                this.progressbar += 100 / iterations;

                if (iterationCount >= iterations) {
                    clearInterval(this.interval);
                    setTimeout(() => {
                        stopsound();
                        this.progressbar = 0;
                        this.progressbarLabel = "";
                    }, 1000);
                }
            }, updateInterval);
        },
        keyHandler(event) {
            if (event.keyCode == 27) {
                if (this.mainShow) {
                    this.mainShow = false;
                } else if (this.requestMenuShow) {
                    this.requestMenuShow = false;
                } else if (this.foringShow) {
                    this.foringShow = false;
                    postNUI("closeForingShow", { foringGameData: this.foringGameData });
                } else if (this.wiringShow) {
                    this.wiringShow = false;
                }

                if (this.switchShow || this.voltShow || this.lineMeterShow) {
                    this.switchShow = false;
                    this.voltShow = false;
                    this.lineMeterShow = false;

                    let regiontrafficKey = this.selectedkey;

                    if (regiontrafficKey && regiontrafficKey.fixed == false) {
                        setTimeout(() => {
                            postNUI("closeNUIHouse", { regiontrafficKey });
                        }, 1000);
                    } else {
                        setTimeout(() => {
                            postNUI("closeNUIFixed", { regiontrafficKey });
                        }, 1000);
                    }

                    postNUI("closeNUI");
                    setTimeout(() => {
                        this.voltShow = false;
                        this.lineMeterShow = false;
                    }, 800);
                }

                this.closeNUI();
            }
        },
        closeNUI() {
            this.mainShow = false;
            postNUI("closeNUI");
        },
        eventHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("checkNUI");
                    break;
                case "OPEN_MENU":
                    this.mainShow = true;
                    this.playerData = event.data.payload;
                    break;
                case "LOAD_LOBBY":
                    this.playerListData = event.data.payload;
                    break;
                case "SERVER_NAME":
                    this.scriptName = event.data.payload;
                    break;
                case "SERVER_MONEY_TYPE":
                    this.moneyType = event.data.payload;
                    break;
                case "REGION_DATA":
                    this.regionData = event.data.payload;
                    break;
                case "LOCALES":
                    this.Locales = event.data.payload;
                    break;
                case "INVITE_MENU":
                    if (this.mainShow) {
                        this.mainShow = false;
                        this.selectRegionData = false;
                        this.playerData = false;
                        this.playerListData = [];
                    }
                    this.requestMenuShow = true;
                    this.requstData["hostName"] = event.data.payload.lobbyOwner;
                    this.requstData["hostIdentifier"] = event.data.payload.identifier;
                    break;
                case "REFRESH_LOBBY":
                    if (event.data.payload == null) return;
                    if (event.data.payload === false) {
                        this.selectRegionData = false;
                    } else {
                        this.selectRegionData = event.data.payload;
                    }
                    break;
                case "CLOSENUI":
                    this.mainShow = false;
                    this.finishShow = false;
                    this.requestMenuShow = false;
                    this.selectRegionData = false;
                    this.playerData = false;
                    this.playerListData = [];
                    break;
                case "SWITCH_MINIGAME":
                    if (this.switchShow || this.voltShow || this.lineMeterShow) {
                        return;
                    } else {
                        this.foundBrokenPano = false;
                        this.switchShow = true;
                        this.selectedkey = event.data.payload;
                        this.randomPanoId = `pano${Math.floor(Math.random() * 12) + 1}`;

                        setTimeout(() => {
                            this.voltShow = true;
                            this.lineMeterShow = true;
                        }, 800);
                    }
                    break;
                case "SWITCH_MINIGAME_HOUSE":
                    if (this.switchShow || this.voltShow || this.lineMeterShow) {
                        return;
                    } else {
                        this.foundBrokenPano = false;
                        this.switchShow = true;
                        this.selectedkey = event.data.payload;
                        this.randomPanoId = `pano${Math.floor(Math.random() * 12) + 1}`;

                        setTimeout(() => {
                            this.voltShow = true;
                            this.lineMeterShow = true;
                        }, 800);
                    }
                    break;
                case "START_JOB":
                    this.mainShow = false;
                    this.progressData = event.data.payload;
                    this.playerShow = true;
                    this.scoreBoxShow = true;
                    this.jobStart = true;
                    break;
                case "REFRESH_JOBTASK":
                    this.progressData = event.data.payload;
                    break;
                case "NOTIFICATION":
                    this.notifications.push(event.data.payload);
                    this.notifyShow = true;
                    break;
                case "CLOSE_TRAFO_MISSION":
                    this.foundBrokenPano = false;
                    this.switchShow = false;
                    this.voltShow = false;
                    this.lineMeterShow = false;
                    break;
                case "CLOSE_WIRING":
                    this.wiringShow = false;
                    break;
                case "WIRING_MINIGAME":
                    this.wiringShow = true;
                    window.drag(event.data.payload);
                    break;
                case "START_MINIGAME_CABLETWO":
                    this.foringShow = true;
                    this.foringGameData = event.data.payload;
                    window.fourminigame(event.data.payload, null, false);
                    break;
                case "FINISH_JOB":
                    this.progressData = false;
                    this.scoreBoxShow = false;
                    this.playerShow = false;
                    this.selectRegionData = false;
                    this.finishShow = true;
                    this.finishjobData = event.data.payload;
                    setTimeout(() => {
                        this.finishShow = false;
                        this.finishjobData = false;
                    }, 5000);
                    this.jobStart = false;
                    break;
                case "LIFT_INFO":
                    this.liftInfoShow = event.data.payload;
                    break;
                case "showProgressBar":
                    this.startProgress(event.data.payload.label, event.data.payload.time);
                    break;
                case "RESET_JOB":
                    this.progressData = false;
                    this.scoreBoxShow = false;
                    this.playerShow = false;
                    this.selectRegionData = false;
                    this.finishShow = false;
                    this.finishjobData = false;
                    this.jobStart = false;
                    this.closeNUI();
                    break;

                default:
                    break;
            }
        }
    },
    computed: {
        progressPercentage() {
            if (this.playerData.playerXp == null || this.playerData.playerNextXp == null) return 0;
            let percentage = (this.playerData.playerXp / this.playerData.playerNextXp) * 100;
            if (percentage > 100) {
                return 100;
            }
            return percentage;
        },
        requiredPercentage() {
            if (this.playerData.playerXp == null || this.playerData.playerNextXp == null) return 0;
            let percentage = (this.playerData.playerNextXp / this.playerData.playerNextXp) * 100;
            if (percentage > 100) {
                return 100;
            }
            return percentage;
        }
    }
});

app.use(store).mount("#app");
var resourceName = "tworst-electrician";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}

function stopsound() {
    if (audioPlayer) {
        audioPlayer.stop();
    }
}

console.clear();
window.drag = function (value) {
    var value = value;
    let completedLights = [0, 0, 0, 0];
    new Draggable(".drag-1", {
        onDrag: function () {
            updateLine(".line-1", this.x + 120, this.y + 200);
        },
        onRelease: function () {
            if (this.x !== 670 || this.y !== 188) {
                reset(".drag-1", ".line-1", 70, 185);
                toggleLight(2, false);
            } else if (this.x === 670 && this.y === 188) toggleLight(2, true);
        },
        liveSnap: { points: [{ x: 670, y: 188 }], radius: 20 }
    });
    new Draggable(".drag-2", {
        onDrag: function () {
            updateLine(".line-2", this.x + 120, this.y + 375);
        },
        onRelease: function () {
            if (this.x !== 670 || this.y !== -188) {
                reset(".drag-2", ".line-2", 60, 375);
                toggleLight(1, false);
            } else if (this.x === 670 && this.y === -188) toggleLight(1, true);
        },
        liveSnap: { points: [{ x: 670, y: -188 }], radius: 20 }
    });
    new Draggable(".drag-3", {
        onDrag: function () {
            updateLine(".line-3", this.x + 120, this.y + 560);
        },
        onRelease: function () {
            if (this.x !== 670 || this.y !== 0) {
                reset(".drag-3", ".line-3", 60, 560);
                toggleLight(3, false);
            } else if (this.x === 670 && this.y === 0) toggleLight(3, true);
        },
        liveSnap: { points: [{ x: 670, y: 0 }], radius: 20 }
    });
    new Draggable(".drag-4", {
        onDrag: function () {
            updateLine(".line-4", this.x + 120, this.y + 745);
        },
        onRelease: function () {
            if (this.x !== 670 || this.y !== 0) {
                reset(".drag-4", ".line-4", 60, 745);
                toggleLight(4, false);
            } else if (this.x === 670 && this.y === 0) toggleLight(4, true);
        },
        liveSnap: { points: [{ x: 670, y: 0 }], radius: 20 }
    });
    function updateLine(selector, x, y) {
        gsap.set(selector, {
            attr: {
                x2: x,
                y2: y
            }
        });
    }

    function toggleLight(selector, visibility) {
        if (visibility) {
            completedLights[selector - 1] = 1;
            if (completedLights[0] === 1 && completedLights[1] === 1 && completedLights[2] === 1 && completedLights[3] === 1) {
                $.post(
                    "https://tw-electrician/fixWirings",
                    JSON.stringify({
                        coords: value.coords,
                        missionName: value.missionName
                    })
                );

                window.setTimeout(() => {
                    reset(".drag-1", ".line-1", 70, 185);
                    reset(".drag-2", ".line-2", 60, 375);
                    reset(".drag-3", ".line-3", 60, 560);
                    reset(".drag-4", ".line-4", 60, 745);
                    toggleLight(2, false);
                    toggleLight(1, false);
                    toggleLight(3, false);
                    toggleLight(4, false);
                }, 2000);
            }
        } else {
            completedLights[selector - 1] = 0;
        }
    }

    function reset(drag, line, x, y) {
        gsap.to(drag, {
            duration: 0.3,
            ease: "power2.out",
            x: 0,
            y: 0
        });
        gsap.to(line, {
            duration: 0.3,
            ease: "power2.out",
            attr: {
                x2: x,
                y2: y
            }
        });
    }
};

window.fourminigame = function (eventdata, cbdata, endgamebool) {
    const COLORS = [
        {
            active: "linear-gradient(to right, rgb(128, 0, 0) 0%, red 45%, red 55%, rgb(128, 0, 0))",
            inactive: "linear-gradient(to right, rgb(48, 0, 0) 0%, rgb(128, 0, 0) 45%, rgb(128, 0, 0) 55%, rgb(48, 0, 0))"
        },
        {
            active: "linear-gradient(to right, rgb(88, 88, 0) 0%, yellow 45%, yellow 55%, rgb(88, 88, 0))",
            inactive: "linear-gradient(to right, rgb(48, 48, 0) 0%, rgb(88, 88, 0) 45%, rgb(88, 88, 0) 55%, rgb(48, 48, 0))"
        },
        {
            active: "linear-gradient(to right, rgb(0, 88, 0) 0%, green 45%, green 55%, rgb(0, 88, 0))",
            inactive: "linear-gradient(to right, rgb(0, 48, 0) 0%, rgb(0, 88, 0) 45%, rgb(0, 88, 0) 55%, rgb(0, 48, 0))"
        },
        {
            active: "linear-gradient(to right, rgb(35, 65, 90) 0%, rgb(70, 130, 180) 45%, rgb(70, 130, 180) 55%, rgb(35, 65, 90))",
            inactive: "linear-gradient(to right, rgb(18, 32, 45) 0%, rgb(35, 65, 90) 45%, rgb(35, 65, 90) 55%, rgb(18, 32, 45))"
        },
        {
            active: "linear-gradient(to right, #A36A00 0%, #FFA500 45%, #FFA500 55%, #A36A00)",
            inactive: "linear-gradient(to right, #754C00 0%, #A36A00 45%, #A36A00 55%, #754C00)"
        }
    ];

    var doorStatus = false;
    var mouse = { x: 0, y: 0 };
    var wires = [];
    var currentWeld;
    var currentTimer;
    var currentTimerLoop;
    var currentGame;
    var audioInstances = {};

    function SetDoor(bool, cb) {
        doorStatus = bool;
        if (bool) {
            $("#am-overlay").addClass("active");
            setTimeout(function () {
                $("#am-overlay").css("background-image", "none");
            }, 900);
        } else {
            $("#am-overlay").removeClass("active");
            setTimeout(function () {
                $("#am-overlay").css("background-image", `url("./img/hazard.png")`);
            }, 750);
        }
        if (!cb) return;
        setTimeout(function () {
            cb();
        }, 3000);
    }

    function RepeatString(str, count) {
        var finalStr = "";
        for (var i = 0; i < count; i++) {
            finalStr += str;
        }
        return finalStr;
    }

    function randomInt(max) {
        return Math.floor(Math.random() * (max + 1));
    }

    function IsIntInRange(number /**/) {
        var args = arguments;
        for (var i = 0; i < args.length; i++) {
            if (args[i] == number) {
                return true;
            }
        }
        return false;
    }

    function SetWeldPosition(x, y) {
        let div = document.getElementById("ams-welding");
        div.style.left = x + "px";
        div.style.top = y + "px";
    }

    function StopAudio(key) {
        if (audioInstances[key]) {
            audioInstances[key].pause();
            audioInstances[key] = null;
        }
    }

    function PlayAudio(key, loop) {
        if (audioInstances[key]) {
            audioInstances[key].pause();
            audioInstances[key].currentTime = 0;
            audioInstances[key].play().catch(error => {
                console.error("Error playing existing audio instance:", error);
            });
        } else {
            var audio = new Audio("./audio/" + key + ".mp3");
            audio.loop = loop;
            audio.volume = 1.0;

            audio.oncanplaythrough = function () {
                audio.play().catch(error => {
                    console.error("Error playing new audio instance:", error);
                });
            };

            audio.onerror = function (event) {
                console.error("Error loading audio:", event);
                console.error("Error details: ", event.target.error);
            };

            audioInstances[key] = audio;
        }
    }
    function StartWelding(wireIndex, direction) {
        if (currentWeld || wires[wireIndex - 1].wired) return;
        currentWeld = {
            index: wireIndex,
            direction: direction,
            color: wires[wireIndex - 1].color - 1
        };
        var element = $("#ams-nodes > div:nth-child(" + wireIndex + ")");
        var weldElement = $("#ams-nodes > div:nth-child(" + wireIndex + ") > div:nth-child(2)");
        PlayAudio("weld", true);

        $("body").css("cursor", "none");
        $("#ams-welding").css("display", "block");
        SetWeldPosition(mouse.x - 50, mouse.y - 50);

        $.post(
            "https://tw-electrician/welding",
            JSON.stringify({
                toggle: true
            })
        );
    }

    function StopWelding(index) {
        if (!currentWeld) return;
        var weld = currentWeld;
        currentWeld = null;
        var element = $("#ams-nodes > div:nth-child(" + weld.index + ")");
        var weldElement = $("#ams-nodes > div:nth-child(" + weld.index + ") > div:nth-child(2)");
        StopAudio("weld");
        $("body").css("cursor", "unset");
        $("#ams-welding").css("display", "none");

        $.post(
            "https://tw-electrician/welding",
            JSON.stringify({
                toggle: false
            })
        );

        if (weld.direction == index) {
            $(weldElement).css("background", COLORS[weld.color].active);
            wires[weld.index - 1].wired = true;
            PlayAudio("connected");
            CheckGame();
        } else {
            $(weldElement).css("background", COLORS[weld.color].inactive);
            wires[weld.index - 1].wired = false;
            PlayAudio("error");
            currentGame.attemptsLeft -= 1;
            CheckFailGame();
        }
    }

    function WireEvents() {
        $("#ams-nodes > div > div:nth-child(1)").mousedown(function () {
            StartWelding($(this).parent().index() + 1, 0);
        });
        $("#ams-nodes > div > div:nth-child(3)").mousedown(function () {
            StartWelding($(this).parent().index() + 1, 1);
        });
        $("#ams-nodes > div > div:nth-child(1)").mouseup(function () {
            StopWelding(1);
        });
        $("#ams-nodes > div > div:nth-child(3)").mouseup(function () {
            StopWelding(0);
        });
    }

    function CreateWires(wireCount, wireWidth) {
        var _wires = [];
        var html = "";
        var colorIndex = 0;
        var size = wireWidth;
        for (var i = 0; i < wireCount; i++) {
            var wireHtml = `
            <div>
                <div style="width: {SIZE}; background: {COLOR_1};"></div>
                <div style="width: {SIZE}; background: {COLOR_2};"></div>
                <div style="width: {SIZE}; background: {COLOR_1};"></div>
            </div>
            `;
            if (colorIndex >= COLORS.length) {
                colorIndex = 0;
            }
            var color = COLORS[colorIndex];
            wireHtml = wireHtml.replaceAll("{COLOR_1}", color.active);
            wireHtml = wireHtml.replaceAll("{COLOR_2}", color.inactive);
            wireHtml = wireHtml.replaceAll("{SIZE}", size + "vw");
            html += wireHtml;
            colorIndex += 1;
            _wires[i] = {
                size: size,
                color: colorIndex,
                wired: false
            };
        }
        wires = _wires;
        $("#ams-nodes").html(html);
        WireEvents();
    }

    function CheckGame() {
        var missingWire;
        for (var i = 0; i < wires.length; i++) {
            if (!wires[i].wired) {
                missingWire = i;
                break;
            }
        }
        if (missingWire != null) return;
        EndGame(true);
    }

    function CheckFailGame() {
        if (currentGame.attemptsLeft > 0) return;
        EndGame(false);
    }

    function EndGame(success, cancelCallback) {
        if (!currentGame) return;
        if (currentTimerLoop) {
            clearInterval(currentTimerLoop);
        }
        var cb = currentGame.cb;
        currentTimerLoop = null;
        currentTimer = null;
        currentGame = null;
        $("#app-minigame").fadeOut(1000, () => {
            SetDoor(false, function () {
                $("#ams-nodes").html("");
            });
        });
        if (!cb || cancelCallback) return;
        cb(success);
    }

    function DisplayInt(float) {
        var floor = Math.floor(float);
        if (floor < 10) {
            floor = "0" + floor;
        }
        return floor;
    }

    function GetTimerDisplay() {
        var minutes = Math.floor(currentTimer / 60);
        var seconds = currentTimer - minutes * 60;
        if (minutes < 0) {
            return `<span style="color: red">00:00</span>`;
        }
        return DisplayInt(minutes) + ":" + DisplayInt(seconds);
    }

    function StartTimer(seconds) {
        if (currentTimer) return;
        currentGame.started = true;
        currentTimer = seconds;
        $("#am-timer").html(GetTimerDisplay());
        currentTimerLoop = setInterval(() => {
            PlayAudio("tick");
            var display = GetTimerDisplay();
            currentTimer -= 1;
            if (currentTimer <= 0) {
                currentTimer = 0;
                $("#am-timer").html(`<span style="color: red">${display}</span>`);
                EndGame(false);
            } else if (currentTimer < 10) {
                $("#am-timer").html(`<span style="color: red">${display}</span>`);
            } else {
                $("#am-timer").html(display);
            }
        }, 1000);
    }

    function StartGame(settings, cb) {
        if (currentGame) return;
        currentGame = settings;
        currentGame.attemptsLeft = settings.maxWeldFails ? settings.maxWeldFails : 3;
        currentGame.started = false;
        currentGame.cb = cb;
        $("#am-timer").html("");
        $("#app-minigame").fadeIn(1000);
        CreateWires(settings.wireCount, settings.wireWidth);
    }

    function OnGameCompleted(success) {
        $.post(
            "https://tw-electrician/gameCompleted",
            JSON.stringify({
                success: success
            })
        );
    }

    $(document).ready(() => {
        $("#am-overlay").on("click", function (ev) {
            if (!currentGame || currentGame.started) return;
            StartTimer(currentGame.time);
            CreateWires(currentGame.wireCount, currentGame.wireWidth);
            SetDoor(!doorStatus);
        });
    });

    document.addEventListener("mousemove", function (e) {
        mouse.x = e.clientX;
        mouse.y = e.clientY;

        if (!currentWeld) return;

        var x = mouse.x;
        var y = mouse.y;

        var index = currentWeld.index;

        var weldElement = $("#ams-nodes > div:nth-child(" + index + ") > div:nth-child(2)");
        var startElement = $("#ams-nodes > div:nth-child(" + index + ") > div:nth-child(1)");
        var endElement = $("#ams-nodes > div:nth-child(" + index + ") > div:nth-child(3)");

        var elemRect = $(weldElement)[0].getBoundingClientRect();
        var startRect = $(startElement)[0].getBoundingClientRect();
        var endRect = $(endElement)[0].getBoundingClientRect();

        var min = { x: elemRect.x, y: startRect.y };
        var max = { x: elemRect.x + elemRect.width, y: endRect.y + endRect.height };

        if (x + 1 < min.x || x - 1 > max.x || y + 1 < min.y || y - 1 > max.y) {
            StopWelding();
        }

        SetWeldPosition(x - 50, y - 50);
    });

    document.addEventListener("mouseup", function (ev) {
        if (!currentWeld) return;
        setTimeout(() => {
            if (!currentWeld) return;
            StopWelding();
        }, 100);
    });
    document.addEventListener("keydown", function (ev) {
        if (ev.key === "Escape") {
            EndGame(false, true);
        }
    });
    StartGame(eventdata, OnGameCompleted);
};
