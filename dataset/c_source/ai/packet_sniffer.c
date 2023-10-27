#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/ether.h>
#include <arpa/inet.h>

#define PACKET_BUFFER_SIZE 65536

void packet_handler(unsigned char *buffer, int size) {
    struct ip *ip_header = (struct ip *)(buffer + sizeof(struct ether_header));

    printf("Packet captured: Destination IP = %s\n", inet_ntoa(ip_header->ip_dst));
}

int main() {
    int raw_socket;
    unsigned char buffer[PACKET_BUFFER_SIZE];
    struct sockaddr saddr;
    int saddr_len;

    // Create a raw socket that receives all packets
    raw_socket = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if (raw_socket == -1) {
        perror("Socket error");
        exit(1);
    }

    while (1) {
        saddr_len = sizeof(saddr);

        // Capture a packet
        int data_size = recvfrom(raw_socket, buffer, PACKET_BUFFER_SIZE, 0, &saddr, (socklen_t *)&saddr_len);
        if (data_size < 0) {
            perror("Packet receive error");
            close(raw_socket);
            exit(1);
        }

        // Handle the captured packet
        packet_handler(buffer, data_size);
    }

    close(raw_socket);
    return 0;
}

